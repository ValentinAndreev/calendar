# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'actions' do
    let(:user) { create(:user) }
    let(:event) { create(:event) }
    before { sign_in(user) }

    context 'user can see month events' do
      before { get :index }

      it { is_expected.to render_template(:index) }
      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(200)
      end
    end

    context 'user can create event' do
      subject { post 'create', params: { event: attributes_for(:event) } }

      it 'saves the new event to database' do
        expect { subject }.to change(Event.all, :count).by(1)
      end

      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(200)
      end
    end

    context 'user can delete event' do
      it 'delete event' do
        delete 'destroy', params: { id: event.id }
        expect(Event.exists?(event.id)).to eq false
      end

      it 'should respond with a success status code (2xx)' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
