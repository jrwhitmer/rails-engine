class Api::V1::ItemsController < ApplicationController

  def create
    render json: Item.create(item_params)
  end

  def update
    render json: Item.update(params[:id], item_params)
  end

  def find
    if params[:name].present? && params[:min_price].present?
      #error
    elsif params[:name].present? && params[:max_price].present?
      #error
    elsif params[:name].present?
      render json: Item.find_one_by_name(params[:name])
    elsif params[:min_price].present? && params[:max_price].present?
      render json: Item.find_one_by_min_max(params[:min_price], params[:max_price])
    elsif params[:min_price].present?
      render json: Item.find_one_by_min(params[:min_price])
    elsif params[:max_price].present?
      render json: Item.find_one_by_max(params[:max_price])
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end
