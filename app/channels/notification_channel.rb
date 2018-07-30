class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'notify'
  end
end
