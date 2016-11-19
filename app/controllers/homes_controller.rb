class HomesController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    url = "https://apkpure.co/"
    @doc = Nokogiri::HTML(open(url))
    xml_file = open(url+ 'sitemap.xml')
    @xml = Nokogiri::HTML(xml_file)
  end

  def scrape_store
    url = "https://play.google.com/store/apps/new"
    @doc = Nokogiri::HTML(open(url))
    @cover=@doc.css(".cover-image")
    @developer=@doc.css(".subtitle")
  end

  def updated_scrape_store
    url = "https://play.google.com/store/apps/new"
    @doc = Nokogiri::HTML(open(url))
    @new_free_apps=@doc.css(".cards-transition-enabled:nth-child(1) .card-click-target")

    @new_paid_apps=@doc.css(".cards-transition-enabled:nth-child(2) .card-click-target")
    @new_free_games=@doc.css(".cards-transition-enabled:nth-child(3) .card-click-target")
    @new_paid_games=@doc.css(".cards-transition-enabled:nth-child(4) .card-click-target")
    @cover=@doc.css(".cover-image")
    @developer=@doc.css(".subtitle")
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
