class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index

  end

  def sales
    results = {}
    Sale.find_each do |sale|
      results["_#{sale.topojson_key}"] = sale.number_of_sales
    end
    render json: results
  end
end
