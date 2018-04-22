# frozen_string_literal: true

class Message::DeadlinesController < Message::BaseController
  protected

  def resource_class
    DeadlineMessage
  end

  def permit_params
    [:deadline, :title, :all_day]
  end
end
