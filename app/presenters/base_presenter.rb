# frozen_string_literal: true

# Base presenter
class BasePresenter
  include ActionView::Helpers::UrlHelper

  def routes
    Rails.application.routes.url_helpers
  end

  def recurrent_date(recurrents, date)
    RecurrentEventService.new.find_by_date(recurrents, date)
  end
end
