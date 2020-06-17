require 'rails_helper'

RSpec.describe "Events Webhooks", type: :request do
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
end