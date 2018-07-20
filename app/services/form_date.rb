# frozen_string_literal: true

class FormDate
  def call(start_date)
    form_date(start_date) || Date.today
  end

  private

  def form_date(start_date)
    return start_date.to_date if start_date.respond_to?(:to_date)
    (start_date['year'] + '-' + start_date['month'] + '-' + start_date['day']).to_date if start_date
  end
end
