class AppController < ApplicationController
  def index
    if user_signed_in?
      @topics_events = []
      @filter = current_user.filter
      filter_params = {}
      unless @filter.nil?
        filter_params[:city] = @filter.city unless @filter.city.empty?
        unless @filter.start_date.nil? && @filter.end_date.nil?
          filter_params[:start_date] = @filter.start_date..@filter.end_date
        end
        unless @filter.topics.empty?
          puts @filter.topics.split(', ').inspect
          Topic.where(name: @filter.topics.split(', ')).map do |topic|
            @topics_events << topic.events
          end
        end
      end
      return @events = Event.all.where(filter_params) if @topics_events.empty?
      @events = @topics_events.flatten.uniq & Event.all.where(filter_params)
    else
      @events = Event.all
    end
  end
end
