# frozen_string_literal: true

require 'rails_helper'

describe FormattingDate do
  it 'empty start_date returns Date.today' do
    result = FormattingDate.call(start_date: nil)

    expect(result).to be_success
    expect(result['date']).to eq(Date.today)
  end

  it 'convert string date to date format' do
    result = FormattingDate.call(start_date: '2018-01-01')

    expect(result).to be_success
    expect(result['date']).to eq(Date.new(2018, 1, 1))
  end

  it 'convert hash date to date format' do
    result = FormattingDate.call(start_date: { 'year' => '2018', 'month' => '1', 'day' => '1' })

    expect(result).to be_success
    expect(result['date']).to eq(Date.new(2018, 1, 1))
  end
end
