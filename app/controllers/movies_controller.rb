class MoviesController < ApplicationController
  def index
    @movies = []
    response = RestClient.get('http://gschool.github.io/student-apis')
    page = Nokogiri::HTML(response.body)
    links = page.css('a')
    links.each do |link|
      url = link.attr('href') + 'all'

      puts url
      begin
        data = RestClient.get(url)
        res = JSON.parse(data.body)
        res.each do |movie|
          @movies << movie["image_url"]

        end
      rescue => e
        puts e.response
      end

    end
  end


end
