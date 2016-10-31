require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST sign_up' do
    it 'redirect to root after sign up' do
      post :sign_up, user: {name: 'bla', email: 'bla@gmail.com', password: '123123123'}
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'POST login' do
    it 'redirect to root after login' do
      User.create!(name: 'Bla', email: 'bla@gmail.com', password: '123123123')
      post :login, user: {email: 'bla@gmail.com', password: '123123123'}
      expect(response).to redirect_to(root_path)
    end
  end
end