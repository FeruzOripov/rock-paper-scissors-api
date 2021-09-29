require 'rails_helper'

RSpec.describe 'Choices API', type: :request do
  let(:choices) { %w(rock paper scissors) }

  describe 'GET /choices' do
    before { get '/choices' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns list of possible choices' do
      res = JSON.parse(response.body)
      expect(res.size).to eq(3)
      expect(res).to match(choices)
    end
  end

  describe 'GET /get-result' do
    context 'with valid choice' do
      before { get '/get-result', params: { choice: 'paper' } }

      it 'returns result of the game' do
        expect(response.body).to match(/You won|You lost|Draw/)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'without params' do
      before { get '/get-result' }

      it 'returns parameter missing error' do
        expect(response.body).to match('choice is missing or the value is empty, visit /choices to get list of choices')
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end

    context 'invalid choice' do
      before { get '/get-result', params: { choice: 'Hammer' } }

      it 'returns invalid choice error' do
        expect(response.body).to match('invalid choice, visit /choices to get list of choices')
      end

      it 'returns status code 400' do
        expect(response).to have_http_status(400)
      end
    end
  end
end
