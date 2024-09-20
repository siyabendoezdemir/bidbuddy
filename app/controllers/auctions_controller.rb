class AuctionsController < ApplicationController
  before_action :authenticate_account!
  before_action :ensure_seller, only: [ :new, :create ]

  def index
    @active_auctions = Auction.where(status: "active").includes(:item).order(endTime: :asc)
  end

  def show
    @auction = Auction.includes(:item, :bids).find(params[:id])
  end

  def new
    @item = current_account.items.find(params[:item_id])
    @auction = @item.build_auction
  end

  def create
    @item = current_account.items.find(params[:auction][:item_id])
    @auction = @item.build_auction(auction_params)
    @auction.currentPrice = @item.startingPrice
    @auction.status = "pending"  # Changed from 'active' to 'pending'

    if @auction.save
      redirect_to @auction, notice: "Auction was successfully created and is pending approval."
    else
      render :new
    end
  end

  private

  def auction_params
    params.require(:auction).permit(:startTime, :endTime)
  end

  def ensure_seller
    unless current_account.role == "seller"
      redirect_to root_path, alert: "Access denied. Sellers only."
    end
  end
end
