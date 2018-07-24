class WeathersController < ApplicationController

  def localities
  end

  def weather_report
    @weather_details = YahooService.new("2488836").generate_weather_info
    if @weather_details.present?
    else
      flash[:notice] = "No weather update found"
      redirect_back fallback_location: "/localities"
    end
  end
end
