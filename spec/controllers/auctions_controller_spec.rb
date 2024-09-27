require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:seller) { create(:account, role: 'seller') }
  let(:buyer) { create(:account, role: 'buyer') }
  let(:item) { create(:item, seller: seller) }
  let(:auction) { create(:auction, item: item) }

  describe 'GET #index' do
    it 'returns a success response' do
      session[:account_id] = buyer.id  # Simulate logged-in user
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      session[:account_id] = buyer.id  # Simulate logged-in user
      get :show, params: { id: auction.to_param }
      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    context 'when user is a seller' do
      before { session[:account_id] = seller.id }

      it 'returns a success response' do
        get :new, params: { item_id: item.id }
        expect(response).to be_successful
      end
    end

    context 'when user is not a seller' do
      before { session[:account_id] = buyer.id }

      it 'redirects to root path' do
        get :new, params: { item_id: item.id }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe 'POST #create' do
    context 'when user is a seller' do
      before { session[:account_id] = seller.id }

      context 'with valid params' do
        it 'creates a new Auction' do
          expect {
            post :create, params: { auction: attributes_for(:auction, item_id: item.id) }
          }.to change(Auction, :count).by(1)
        end

        it 'redirects to the created auction' do
          post :create, params: { auction: attributes_for(:auction, item_id: item.id) }
          expect(response).to redirect_to(Auction.last)
        end
      end

      context 'with invalid params' do
        it 'returns a success response (i.e. to display the new template)' do
          post :create, params: { auction: attributes_for(:auction, item_id: item.id, startTime: nil) }
          expect(response).to be_successful
        end
      end
    end
  end
end
