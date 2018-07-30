class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @comments = @event.comments.order(:created_at)
    create_notification @event
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        create_notification(@event)
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:name, :description, :city, :start_date, :end_date, :all_topics)
  end

  def create_notification(event)
    message = 'New event by you filter'
    Filter.all.where(load_event_params(event)).each do |filter|
      if !(filter.start_date.nil? && filter.end_date.nil?)
        if filter.start_date <= event.start_date && filter.end_date >= event.start_date
          Notification.create(body: message, user_id: filter.user_id, is_active: false)
          ActionCable.server.broadcast 'notify', message: message
        end
      else
        Notification.create(body: message, user_id: filter.user_id, is_active: false)
        ActionCable.server.broadcast 'notify', message: message
      end
    end
  end

  def load_event_params(event)
    params = {}
    params[:city] = [event.city, ''] unless event.city.empty?
    params[:topics] = [event.all_topics.tr(',', ''), '']
    params
  end
end
