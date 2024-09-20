# app/controllers/dashboards_controller.rb

class DashboardsController < ApplicationController
  before_action :authenticate_account!

  def show
    case current_account.role
    when "buyer"
      @active_auctions = Auction.where(status: "active").includes(:item).order(endTime: :asc).limit(10)
      @my_bids = current_account.bids.includes(auction: :item).order(created_at: :desc).limit(5)
    when "seller"
      @my_items = current_account.items.includes(:auction).order(created_at: :desc)
      @active_auctions = Auction.joins(:item)
                                .where(items: { seller_id: current_account.id }, status: "active")
                                .order(endTime: :asc)
    when "admin"
      @recent_auctions = Auction.order(created_at: :desc).limit(10)
      @recent_accounts = Account.order(created_at: :desc).limit(10)
    end
  end
end
