# app/controllers/bids_controller.rb

class BidsController < ApplicationController
  before_action :authenticate_account!
  before_action :set_auction

  def create
    @bid = @auction.bids.new(bid_params)
    @bid.bidder = current_account
    @bid.timestamp = Time.current

    if @bid.save
      @auction.update(currentPrice: @bid.amount)
      redirect_to @auction, notice: "Bid was successfully placed."
    else
      redirect_to @auction, alert: "Error placing bid."
    end
  end

  private

  def set_auction
    @auction = Auction.find(params[:auction_id])
  end

  def bid_params
    params.require(:bid).permit(:amount)
  rescue ActionController::ParameterMissing
    # If the :bid parameter is missing, return an empty hash
    # This will cause the bid to fail validation, and the user will be redirected with an error message
    {}
  end
end
