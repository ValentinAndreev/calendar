# frozen_string_literal: true

class FormattingDate < Trailblazer::Operation
  step :form_date!

  private

  def form_date!(options, start_date:, **)
    options['date'] = if start_date.respond_to?(:to_date)
      start_date.to_date
    elsif start_date
      (start_date['year'] + '-' + start_date['month'] + '-' + start_date['day']).to_date
    else
      Date.today
    end
  end
end
