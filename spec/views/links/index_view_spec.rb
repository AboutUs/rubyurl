require 'spec_helper'

describe "links/index" do
  before(:each) do
    render :template => 'links/index'
  end

  it "should display Create a RubyURL in a h1 tag" do
    rendered.should have_tag('label', :text => 'Create a RubyURL')
  end

  it "should display a text input field for the user to paste their url in" do
    rendered.should have_tag('input#link_website_url')
  end
end

describe "links/show" do
  before(:each) do
    @link = mock_model(Link)
    @link.stub!(:permalink).and_return('http://localhost:3000/x093')
    @link.stub!(:website_url).and_return('http://rubyurl.com/')
    assigns[:link] = @link
    render :template => 'links/show'
  end

  it "should display Here is your RubyURL in a h1 tag" do
    rendered.should have_tag('dt', :text => 'Here is your RubyURL')
  end

  it "should display a link for the user to copy" do
    rendered.should have_tag('div#url')
    rendered.should have_tag('a', :text => 'http://localhost:3000/x093')
  end

  it "should display the correct number of characters for the original URL (16)" do
    rendered.should have_tag('dd', :text => '19 characters')
  end
end
