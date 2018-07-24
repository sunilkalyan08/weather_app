class WeathersController < ApplicationController

  def index
  end

  def weather_report
    @weather_id = $localities[params["city"]]
    @weather_details = YahooService.new(@weather_id).generate_weather_info
    if @weather_details.present?
    else
      flash[:notice] = "No weather update found"
      redirect_back fallback_location: "/localities"
    end
  end
end
