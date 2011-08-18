class LinksController < ApplicationController
  caches_page :home, :about, :api, :report

  def index
    @link = Link.new
    render :action => 'index'
  end

  def create
    params[:link] ||= {}
    params[:link][:website_url] ||= params[:website_url]

    @link = Link.new(params[:link])
    @link.source_uri = 'http://' + request.env['HTTP_HOST']
    @link.ip_address = request.remote_ip if @link.new_record?

    if @link.save
      render :action => :show
    else
      flash[:warning] = @link.errors.inspect
      render :action => 'invalid'
    end
  end

  def show
    @link = Link.find_by_token( params[:token] )

    unless @link.nil?
      @link.add_visit(request)
      redirect_to @link.website_url, { :status => 301 }
    else
      redirect_to :action => 'invalid'
    end
  end
end
