# app/controllers/admin_controller.rb

class AdminController < ApplicationController
  before_action :authenticate_account!
  before_action :ensure_admin

  def index
    @pending_auctions = Auction.where(status: "pending").includes(:item)
    @active_auctions = Auction.where(status: "active").includes(:item)
    @ended_auctions = Auction.where(status: "ended").includes(:item)
  end

  def review_auction
    @auction = Auction.find(params[:id])
  end

  def process_auction
    @auction = Auction.find(params[:id])

    if params[:approve]
      @auction.update(status: "active")
      redirect_to admin_path, notice: "Auction approved successfully."
    elsif params[:decline]
      if params[:admin_message].present?
        @auction.update(status: "declined", admin_message: params[:admin_message])
        redirect_to admin_path, notice: "Auction declined successfully."
      else
        redirect_to review_auction_admin_path(@auction), alert: "Admin message is required when declining an auction."
      end
    end
  end

  private

  def ensure_admin
    unless current_account && current_account.role == "admin"
      redirect_to root_path, alert: "Access denied. Admins only."
    end
  end
end
