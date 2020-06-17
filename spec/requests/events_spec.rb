require 'rails_helper'

RSpec.describe "Events", type: :request do

  it "should be able to create a new event" do
    params = { issue: { number: 7 }, action: 'edited' }
    signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'), ENV['GITHUB_WEBHOOK_SECRET'], params.to_json)
    headers = {
      'X-GitHub-Event': 'issues',
      'X-Hub-Signature': signature
    }
    post '/events', params: params, headers: headers, as: :json
    expect(response).to have_http_status(:created)
  end

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
