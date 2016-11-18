class HomesController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    url = "https://apkpure.co/"
    @doc = Nokogiri::HTML(open(url))
    xml_file = open(url+ 'sitemap.xml')
    @xml = Nokogiri::HTML(xml_file)
  end

  def download_csv
    require 'csv'
    url = "https://apkpure.co/"
    xml_file = open(url+ 'sitemap.xml')
    xml = Nokogiri::HTML(xml_file)
    csv_string = CSV.generate do |csv|
      csv << ["link"]
      xml.css("loc").each do |item|
        csv << [item.text]
      end
    end

    respond_to do |format|
      format.csv { send_data csv_string, filename: "sitemap-links.csv" }
    end
  end
end
