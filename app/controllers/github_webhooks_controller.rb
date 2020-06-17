class GithubWebhooksController < ApplicationController
  include GithubWebhook::Processor

  def github_issues(payload)
    @event = Event.new(action: payload["action"],
                    number: payload["issue"]["number"])

    if @event.save
      render json: @event, status: :created
    else
      render json: @event.errors, status: :bad_request
    end
  end

  def create
    if self.respond_to?(event_method, true)
      self.send event_method, json_body
    else
      raise NoMethodError.new("GithubWebhooksController##{event_method} not implemented")
    end
  end

  private

  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end
end