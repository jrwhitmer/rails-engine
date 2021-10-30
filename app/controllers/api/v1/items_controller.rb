class Api::V1::ItemsController < ApplicationController

  def update
    render json: Item.update(params[:id], item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end
