require 'rails_helper'

RSpec.describe SessionsController do
  describe 'routing' do
    it 'routes GET /login to SessionsController#login' do
      expect(get: '/login').to route_to(controller: 'sessions', action: 'login')
    end

    it 'routes GET /sign_up to SessionsController#sign_up' do
      expect(get: '/sign_up').to route_to(controller: 'sessions', action: 'sign_up')
    end

    it 'routes GET /sign_out to SessionsController#sign_out' do
      expect(get: '/sign_out').to route_to(controller: 'sessions', action: 'sign_out')
    end

    it 'routes GET /events/6 to EventsController#show' do
      expect(get: '/events/6').to route_to(controller: 'events', action: 'show', id: '6')
    end

    it 'routes GET /events/6/tickets/create_type to TicketsController#create_type' do
      expect(get: '/events/6/tickets/create_type').to route_to(controller: 'tickets', action: 'create_type', event_id: '6')
    end
  end
end