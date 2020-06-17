class Event < ApplicationRecord
  validates :action, :number, presence: true
end
