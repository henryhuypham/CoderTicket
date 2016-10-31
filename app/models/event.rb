class Event < ActiveRecord::Base
  belongs_to :venue
  belongs_to :category
  belongs_to :creator, class_name: 'User'
  has_many :ticket_types
  has_many :ticket_orders
  has_many :ticket_buyers, through: :ticket_orders

  validates_presence_of :extended_html_description, :venue, :category, :starts_at, :creator
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.valid_published_events
    Event.where('starts_at >= ? AND published = ?', Date.today, true)
  end

  def self.search_events(keyword)
    Event.where('lower(name) LIKE lower(?) AND starts_at >= ? AND  published = ?', keyword, Date.today, true)
  end

  def self.update_event(event_params, event_id, venue_id, category_id)
    venue = Venue.find_by(id: venue_id)
    unless venue.present?
      raise 'Invalid venue!'
    end

    category = Category.find_by(id: category_id)
    unless category.present?
      raise 'Invalid category!'
    end

    event = Event.find(event_id)
    unless event.present?
      raise 'Invalid event!'
    end
    event.attributes = event_params

    unless event.starts_at >= Date.today
      raise 'Event needs to be in the future!'
    end
    unless event.ends_at.present? && event.starts_at <= event.ends_at
      raise 'Start date must be before or equal to end date!'
    end

    event.save!
    return event
  end

  def has_enough_ticket_type?
    ticket_types.present?
  end
end
