class EventsController < ApplicationController

  # GET /events
  def index
    @events = Event.all
    render json: @events
  end

  # GET /issues/1/events
  def issues
    event = Event.find_by(number: params[:number])

    if !event
      render status: :not_found
    else
      @event = Event.where(number: params[:number]).order(created_at: :desc)
      render json: @event, only: [:action, :created_at], status: :ok
    end
  end

  # POST /events
  def create
    @event = Event.new(number: params["issue"]["number"], 
                        action: params["event"]["action"])

    if @event.save
      render json: @event, status: :created
    else
      render json: @planet.erros, status: :bad_request
    end
  end

  private
    def event_params
      params.require(:event).permit(:action, :number)
    end
end
