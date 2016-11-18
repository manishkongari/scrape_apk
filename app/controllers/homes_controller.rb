class HomesController < ApplicationController
  def index
    require 'nokogiri'
    require 'open-uri'
    url = "https://apkpure.co/"
    @doc = Nokogiri::HTML(open(url))
    @xml = Nokogiri::XML(open(url+ 'sitemap.xml'))

  end
end
