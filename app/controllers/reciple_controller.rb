class RecipleController < ApplicationController
  def recipe_search2
    require 'nokogiri'
    require 'open-uri'
    require 'openssl'
    require 'uri'

    @keyword = params[:keyname]
    @rakuten_url = URI.parse URI.encode "https://recipe.rakuten.co.jp/search/#{@keyword}"
    @cookpad_url = URI.parse URI.encode "https://cookpad.com/search/#{@keyword}"
    @kurashiru_url = URI.parse URI.encode"https://www.kurashiru.com/search?utf8=✓&query=#{@keyword}"
    @nadia_url = URI.parse URI.encode"https://oceans-nadia.com/search?q=#{@keyword}"

    @doc = Nokogiri::HTML(open(@rakuten_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
    @doc2 = Nokogiri::HTML(open(@cookpad_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
    @doc3 = Nokogiri::HTML(open(@kurashiru_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
    @doc4 = Nokogiri::HTML(open(@nadia_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

    @imgs_box = []
    @imgs_box2 = []
    @imgs_box3 = []
    @imgs_box4 = []

    @urls_box = []
    @urls_box2 = []
    @urls_box3 = []
    @urls_box4 = []

    @titles_box = []
    @titles_box2 = []
    @titles_box3 = []
    @titles_box4 = []

    before = "https://recipe.rakuten.co.jp/"
    before2 = "https://cookpad.com"
    before3 = "https://www.kurashiru.com"
    before4 = "https://oceans-nadia.com"

    #楽天レシピのsrc,alt,hrefを取得
    @doc.xpath("//*[@id=\"recipe_food_image\"]").each do |info|
      @imgs_box.push(info[:src]).uniq
      @titles_box.push(info[:alt]).uniq
    end

    @doc.xpath("//*[@id=\"recipe_detail_link\"]").each do |url|
      @urls_box.push(before + url[:href]).uniq
    end

    #cookpadのsrc,alt,hrefを取得
    @doc2.xpath("//*[contains(@src, 'https://img.cpcdn.com/recipes/') and contains(@alt, \'写真\')]").each do |i|
      @imgs_box2.push(i[:src]).uniq
    end

    @doc2.xpath("//*[contains(@class, \"recipe-title font13\")]").each do |i|
      @urls_box2.push(before2 + i[:href]).uniq
      @titles_box2.push(i.text).uniq
    end

    #kurashiruのsrc,alt,hrefを取得
    @doc3.xpath("//*[contains(@src, 'https://video.kurashiru.com/production/videos/') and contains(@class, 'compressed')]").each do |i|
      @imgs_box3.push(i[:src]).uniq
      @titles_box3.push(i[:alt]).uniq
    end

    @doc3.xpath("//*[@class=\"video-list-img\"]").each do |i|
      @urls_box3.push(before3 + i[:href]).uniq
    end

    #Nadiaのsrc,alt,hrefを取得
    @doc4.xpath("//*[not (contains(@class, \"usrPht-fullwidth powertip\")) and contains(@src, \"https://cdn.oceans-nadia.com/upload/save_image_300_300/\")]").each do |photo|
      @imgs_box4.push(photo[:src]).uniq
    end

    @doc4.xpath("//*[@class=\"recipe-titlelink\"]").each do |i|
      @urls_box4.push(before4 + i[:href]).uniq
      @titles_box4.push(i.text).uniq
    end
    render "result_recipe"
  end

  def food_join
    @joins_box = []
    @joins_box = params[:keyname]
    render "search_recipe"
  end

  def join_search
    require 'nokogiri'
    require 'open-uri'
    require 'openssl'
    require 'uri'

    @rakuten_url = URI.parse URI.encode "https://recipe.rakuten.co.jp/search/#{$join}"
    @cookpad_url = URI.parse URI.encode "https://cookpad.com/search/#{$join}"
    @kurashiru_url = URI.parse URI.encode"https://www.kurashiru.com/search?utf8=✓&query=#{$join}"
    @nadia_url = URI.parse URI.encode"https://oceans-nadia.com/search?q=#{$join}"

    @doc = Nokogiri::HTML(open(@rakuten_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
    @doc2 = Nokogiri::HTML(open(@cookpad_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
    @doc3 = Nokogiri::HTML(open(@kurashiru_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
    @doc4 = Nokogiri::HTML(open(@nadia_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

    @imgs_box = []
    @imgs_box2 = []
    @imgs_box3 = []
    @imgs_box4 = []

    @urls_box = []
    @urls_box2 = []
    @urls_box3 = []
    @urls_box4 = []

    @titles_box = []
    @titles_box2 = []
    @titles_box3 = []
    @titles_box4 = []

    before = "https://recipe.rakuten.co.jp/"
    before2 = "https://cookpad.com"
    before3 = "https://www.kurashiru.com"
    before4 = "https://oceans-nadia.com"

    #楽天レシピのsrc,alt,hrefを取得
    @doc.xpath("//*[@id=\"recipe_food_image\"]").each do |info|
      @imgs_box.push(info[:src]).uniq
      @titles_box.push(info[:alt]).uniq
    end

    @doc.xpath("//*[@id=\"recipe_detail_link\"]").each do |url|
      @urls_box.push(before + url[:href]).uniq
    end

    #cookpadのsrc,alt,hrefを取得
    @doc2.xpath("//*[contains(@src, 'https://img.cpcdn.com/recipes/') and contains(@alt, \'写真\')]").each do |i|
      @imgs_box2.push(i[:src]).uniq
    end

    @doc2.xpath("//*[contains(@class, \"recipe-title font13\")]").each do |i|
      @urls_box2.push(before2 + i[:href]).uniq
      @titles_box2.push(i.text).uniq
    end

    #kurashiruのsrc,alt,hrefを取得
    @doc3.xpath("//*[contains(@src, 'https://video.kurashiru.com/production/videos/') and contains(@class, 'compressed')]").each do |i|
      @imgs_box3.push(i[:src]).uniq
      @titles_box3.push(i[:alt]).uniq
    end

    @doc3.xpath("//*[@class=\"video-list-img\"]").each do |i|
      @urls_box3.push(before3 + i[:href]).uniq
    end

    #Nadiaのsrc,alt,hrefを取得
    @doc4.xpath("//*[not (contains(@class, \"usrPht-fullwidth powertip\")) and contains(@src, \"https://cdn.oceans-nadia.com/upload/save_image_300_300/\")]").each do |photo|
      @imgs_box4.push(photo[:src]).uniq
    end

    @doc4.xpath("//*[@class=\"recipe-titlelink\"]").each do |i|
      @urls_box4.push(before4 + i[:href]).uniq
      @titles_box4.push(i.text).uniq
    end
      render "result_recipe"
  end
end
