require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '.valid_published_events' do
    it 'returns [] when there are no event' do
      Event.delete_all
      events = Event.valid_published_events
      expect(events).to eq []
    end

    it 'returns [a] when there is only one event a' do
      a = Event.create!(
          name: 'test product',
          venue: Venue.create!(name: 'Bla', full_address: 'Bla', region: Region.create(name: 'Bla')),
          extended_html_description: 'Bla',
          starts_at: Date.today,
          creator: User.create!(name: 'Bla', email: 'bla@gmail.com', password: '123123123'),
          category: Category.create!(name: 'Entertainment'),
          published: true
      )
      events = Event.valid_published_events
      expect(events).to eq [a]
    end

    it 'returns 2 events when there are 2 valid events' do
      a1 = Event.create!(
          name: 'test product',
          venue: Venue.create!(name: 'Bla', full_address: 'Bla', region: Region.create(name: 'Bla')),
          extended_html_description: 'Bla',
          starts_at: Date.today,
          creator: User.create!(name: 'Bla', email: 'bla@gmail.com', password: '123123123'),
          category: Category.create!(name: 'Entertainment'),
          published: true
      )
      a2 = Event.create!(
          name: 'test product 2',
          venue: Venue.create!(name: 'Bla2', full_address: 'Bla2', region: Region.create(name: 'Bla2')),
          extended_html_description: 'Bla2',
          starts_at: Date.today,
          creator: User.create!(name: 'Bla2', email: 'bla2@gmail.com', password: '123123123'),
          category: Category.create!(name: 'Learning'),
          published: true
      )
      events = Event.valid_published_events
      expect(events.count).to eq 2
    end
  end

  describe '.search_events' do
    it 'returns [] when keyword is irrelevant' do
      a = Event.create!(
          name: 'test product',
          venue: Venue.create!(name: 'Bla', full_address: 'Bla', region: Region.create(name: 'Bla')),
          extended_html_description: 'Bla',
          starts_at: Date.today,
          creator: User.create!(name: 'Bla', email: 'bla@gmail.com', password: '123123123'),
          category: Category.create!(name: 'Entertainment'),
          published: true
      )
      events = Event.search_events('weird name')
      expect(events).to eq []
    end

    it 'returns relevant when keyword is relevant to name of events' do
      a = Event.create!(
          name: 'test product',
          venue: Venue.create!(name: 'Bla', full_address: 'Bla', region: Region.create(name: 'Bla')),
          extended_html_description: 'Bla',
          starts_at: Date.today,
          creator: User.create!(name: 'Bla', email: 'bla@gmail.com', password: '123123123'),
          category: Category.create!(name: 'Entertainment'),
          published: true
      )
      a2 = Event.create!(
          name: 'weird name',
          venue: Venue.create!(name: 'Bla2', full_address: 'Bla2', region: Region.create(name: 'Bla2')),
          extended_html_description: 'Bla2',
          starts_at: Date.today,
          creator: User.create!(name: 'Bla2', email: 'bla2@gmail.com', password: '123123123'),
          category: Category.create!(name: 'Learning'),
          published: true
      )
      events = Event.search_events('test product')
      expect(events).to eq [a]
    end
  end

  describe '.update_event' do
    it 'return event with updated info' do
      venue = Venue.create!(name: 'Bla', full_address: 'Bla', region: Region.create(name: 'Bla'))
      category = Category.create!(name: 'Entertainment')
      a = Event.create!(
          name: 'test product',
          venue: venue,
          extended_html_description: 'Bla',
          starts_at: Date.today,
          ends_at: Date.today,
          creator: User.create!(name: 'Bla', email: 'bla@gmail.com', password: '123123123'),
          category: category,
          published: true
      )
      event_params = {
          name: 'new name',
          extended_html_description: 'new content'
      }
      updated_event = Event.update_event(event_params, a.id, venue.id, category.id)
      expect(updated_event.name).to eq 'new name'
      expect(updated_event.extended_html_description).to eq 'new content'
    end
  end

  describe '.has_enough_ticket_type?' do
    it 'return false when event has no ticket type' do
      a = Event.create!(
          name: 'test product',
          venue: Venue.create!(name: 'Bla', full_address: 'Bla', region: Region.create(name: 'Bla')),
          extended_html_description: 'Bla',
          starts_at: Date.today,
          creator: User.create!(name: 'Bla', email: 'bla@gmail.com', password: '123123123'),
          category: Category.create!(name: 'Entertainment'),
          published: true
      )
      expect(a.has_enough_ticket_type?).to eq false
    end

    it 'return true when event has 1 ticket type' do
      a = Event.create!(
          name: 'test product',
          venue: Venue.create!(name: 'Bla', full_address: 'Bla', region: Region.create(name: 'Bla')),
          extended_html_description: 'Bla',
          starts_at: Date.today,
          creator: User.create!(name: 'Bla', email: 'bla@gmail.com', password: '123123123'),
          category: Category.create!(name: 'Entertainment'),
          published: true
      )
      TicketType.create!(
          event: a,
          price: 100000,
          name: 'bla',
          max_quantity: 100
      )
      expect(a.has_enough_ticket_type?).to eq true
    end
  end
end