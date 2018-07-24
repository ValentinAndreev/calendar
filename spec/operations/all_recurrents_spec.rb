# frozen_string_literal: true

require 'rails_helper'

describe Recurrents::AllRecurents do
  context 'returns all daily recurrent events' do
    let!(:event) { create(:event) }
    let!(:daily_recurrent_event) { create(:event, :daily) }
    it 'get all daily recurrent events except day of event creation' do
      result = Recurrents::AllRecurents.call(events: Event.where(recurrent: 'daily'), date: Date.today.end_of_month.to_date)

      expect(result).to be_success
      days = Time.days_in_month(Date.today.month, Date.today.year) - 1
      expect(result['recurrents'].size).to eq(days)
    end
  end

  context 'returns all weekly recurrent events' do
    let!(:event) { create(:event) }
    let!(:weekly_recurrent_event) { create(:event, :weekly) }
    it 'get all weekly recurrent events except day of event creation' do
      count_of_weekday = (Date.today.beginning_of_month..Date.today.end_of_month).count { |d| d.wday == weekly_recurrent_event.start_time.wday }
      result = Recurrents::AllRecurents.call(events: Event.where(recurrent: 'weekly'), date: Date.today.end_of_month.to_date)

      expect(result).to be_success
      expect(result['recurrents'].size).to eq(count_of_weekday - 1)
    end
  end

  context 'returns montly recurrent events' do
    let!(:event) { create(:event) }
    let!(:monthly_recurrent_event) { create(:event, :monthly) }
    it 'get next month recurrent event' do
      next_mont = Date.today.end_of_month.change(month: Date.today.month + 1)
      result = Recurrents::AllRecurents.call(events: Event.where(recurrent: 'monthly'), date: next_mont.to_date)

      expect(result).to be_success
      expect(result['recurrents'].size).to eq(1)
    end
  end

  context 'returns annually recurrent events' do
    let!(:event) { create(:event) }
    let!(:annually_recurrent_event) { create(:event, :annually) }
    it 'get next annually recurrent event' do
      next_year = Date.today.end_of_month.change(year: Date.today.year + 1)
      result = Recurrents::AllRecurents.call(events: Event.where(recurrent: 'annually'), date: next_year.to_date)

      expect(result).to be_success
      expect(result['recurrents'].size).to eq(1)
    end
  end
end
