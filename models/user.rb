require 'httparty'
require 'uri'
require 'json'

class User < ActiveRecord::Base

  def load_producer_json
    url = URI::encode('http://localhost:3000/provider.json?valid_date=' + Time.now.httpdate)
    puts url
    response = HTTParty.get(url)
    if response.success?
      JSON.parse(response.body)
    end
  end

  def load_producer_json2
    url = URI::encode('http://localhost:3000/provider.string?valid_date=' + 'Happy New Year')
    puts url
    response = HTTParty.get(url)
    if response.success?
      response.body
    end
  end

  def process_data
    data = load_producer_json
    ap data
    value = data['count'] / 100
    date = Time.parse(data['date'])
    puts value
    puts date
    [value, date]
  end

  def process_data2
    data = load_producer_json2
  end

end
