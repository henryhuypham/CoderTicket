require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET created by me events while not logged in' do
    it 'redirect to root path' do
      get :created_by_me
      expect(response).to redirect_to(root_path)
    end
  end
end