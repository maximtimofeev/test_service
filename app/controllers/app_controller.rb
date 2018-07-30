class AppController < ApplicationController
  def index
    @message = ''
    if user_signed_in?
      @topics_events = []
      @filter = current_user.filter
      filter_params = load_filter_params

      return @events = Event.all.where(filter_params) if @topics_events.empty?
      @events = @topics_events.flatten.uniq & Event.all.where(filter_params)
    else
      @events = Event.all
    end
  end

  private

  def topic_events
    events = []
    unless @filter.topics.empty?
      Topic.where(name: @filter.topics.split(', ')).map do |topic|
        events << topic.events
      end
    end
    events
  end

  def load_filter_params
    params = {}
    unless @filter.nil?
      @topics_events = topic_events
      params[:city] = @filter.city unless @filter.city.empty?
      unless @filter.start_date.nil? && @filter.end_date.nil?
        params[:start_date] = @filter.start_date..@filter.end_date
      end
    end
    params
  end
end
