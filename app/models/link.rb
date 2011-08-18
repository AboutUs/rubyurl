require 'domainatrix'
require 'uri'

class Link < ActiveRecord::Base
  TOKEN_LENGTH = 4

  has_many :visits
  has_many :spam_visits, :class_name => 'Visit', :conditions => ["flagged = 'spam'"]

  validates :website_url, :presence => true
  validates :ip_address, :presence => true
  validates :token, :uniqueness => true

  validates_format_of :website_url, :with => /^(http|https):\/\/[a-z0-9]/ix, :message => 'needs to have http(s):// in front of it', :if => Proc.new { |p| p.website_url? }
  validate :not_in_surbl, :if => Proc.new { |p| p.website_url? && p.errors[:website_url].blank? }

  before_create :generate_token
  before_create :build_permalink

  def flagged_as_spam?
    self.spam_visits.empty? ? false : true
  end

  def add_visit(request)
    visit = visits.build(:ip_address => request.remote_ip)
    visit.save
    return visit
  end

  def to_api_xml
    xml = Builder::XmlMarkup.new
    xml.instruct!
    xml.link do
      xml.tag!( :website_url, self.website_url )
      xml.tag!( :permalink, self.permalink )
    end
  end

  def source_uri=(uri_or_url)
    if uri_or_url.is_a?(String)
      @source_uri = URI.parse(uri_or_url)
    else
      @source_uri = uri_or_url
    end
  end

  def source_uri
    @source_uri
  end

  def to_api_json
    self.to_json( :only => [ :website_url, :permalink ] )
  end

  private

  def not_in_surbl
    begin
      url = Domainatrix.parse(self.website_url)
      dig_response = %x[/usr/bin/dig +short #{url.domain}.#{url.public_suffix}.multi.surbl.org]
      Rails.logger.warn("DEBUG: #{dig_response.inspect}")
      errors.add_to_base("SPAM. Domain was found in surbl.") if dig_response =~ /127.0/i
    rescue
    end
  end

  def generate_token
    return if self.token
    if (temp_token = random_token) and self.class.find_by_token(temp_token).nil?
      self.token = temp_token
    else
      generate_token
    end
  end

  def build_permalink
    self.source_uri.path = '/' + self.token
    self.permalink = self.source_uri.to_s
  end

  def random_token
    characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890'
    temp_token = ''
    srand
    TOKEN_LENGTH.times do
      pos = rand(characters.length)
      temp_token += characters[pos..pos]
    end
    temp_token
  end
end

