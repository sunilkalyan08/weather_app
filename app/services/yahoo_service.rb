class YahooService
  require 'uri'
  require 'net/http'

  def initialize weoid
    @auth_key = Rails.application.secrets.auth_key
    @secret = Rails.application.secrets.auth_secret
    @weoid = weoid

  end

  def generate_weather_info
    url = URI("https://query.yahooapis.com/v1/public/yql?oauth_consumer_key=#{@auth_key}&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1532397795&oauth_nonce=1SrIN5&oauth_version=1.0&oauth_signature=FZHEOAnaP1mvfGiI8J0k3Sn8sJg%3D&q=select%20*%20from%20weather.forecast%20where%20woeid%3D#{@weoid}%3B&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)
    response = http.request(request)
    json_response = JSON.parse response.read_body rescue ''
    if json_response.present?
      return json_response["query"]["results"]["channel"]
    else
      return []
    end
  end
end
