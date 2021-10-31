class Api::V1::MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find_by(id: params[:id])
    render json: Merchant.total_revenue(@merchant.id)
  end
end
