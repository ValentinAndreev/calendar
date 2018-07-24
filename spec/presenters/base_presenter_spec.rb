# frozen_string_literal: true

require 'rails_helper'

describe BasePresenter do
  context 'returns all recurrent events of day' do
    let!(:event) { create(:event) }
    let!(:daily_recurrent_event) { create(:event, :daily) }
    it 'get recurrent events of day' do
      result = Recurrents::AllRecurents.call(events: Event.where(recurrent: 'daily'), date: Date.today.end_of_month.to_date)

      recurrents = BasePresenter.new.recurrent_date(result['recurrents'], Date.today.change(day: 2))
      expect(recurrents.size).to eq(1)
    end
  end
end
