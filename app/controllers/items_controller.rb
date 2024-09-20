class ItemsController < ApplicationController
  before_action :authenticate_account!
  before_action :ensure_seller

  def index
    @items = current_account.items.order(created_at: :desc)
  end

  def new
    @item = current_account.items.build
  end

  def create
    @item = current_account.items.build(item_params)
    if @item.save
      redirect_to items_path, notice: "Item was successfully created."
    else
      render :new
    end
  end

  def edit
    @item = current_account.items.find(params[:id])
  end

  def update
    @item = current_account.items.find(params[:id])
    if @item.update(item_params)
      redirect_to items_path, notice: "Item was successfully updated."
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :startingPrice)
  end

  def ensure_seller
    unless current_account.role == "seller"
      redirect_to root_path, alert: "Access denied. Sellers only."
    end
  end
end
