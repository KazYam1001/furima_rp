class PurchaseController < ApplicationController

  def new
    @item = Item.find(params[:id])
  end

end
