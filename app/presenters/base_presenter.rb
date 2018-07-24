# frozen_string_literal: true

# Base presenter
class BasePresenter
  include ActionView::Helpers::UrlHelper

  def routes
    Rails.application.routes.url_helpers
  end

  def recurrent_date(recurrents, date)
    recurrents.find_all { |f| f[:start_time] == date.to_s[0..9] }
  end
end
