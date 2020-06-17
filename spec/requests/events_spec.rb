require 'rails_helper'

RSpec.describe "Events", type: :request do

  it "should be able to list the event" do
    events = Event.all
    get "/events"
    expect(response).to have_http_status(:ok)
    expect(response.parsed_body).to match(events.as_json)
  end

  it "should be able to find events by number" do
    event = Event.create(action: 'opened', number: 7)
    get "/issues/#{event.number}/events"
    expect(response).to have_http_status(:ok)
  end

  it 'should be able generate errors when trying to search for an unregistered events by number' do
    get '/issues/100/events'
    expect(response).to have_http_status(:not_found)
  end
end
