require 'rails_helper'
require 'fakeweb'

RSpec.describe GameService do
  context 'invalid choice' do
    it 'raises error' do
      expect { described_class.new('hammer') }
        .to raise_error(Exceptions::InvalidChoice)
    end
  end

  context 'server is not working' do
    before do
      FakeWeb.register_uri(:get,
                           'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw',
                           body: 'Internal server error',
                           status: ['500', 'Bad Request'])
    end

    it 'raises ServerError' do
      expect { described_class.new('paper').send(:result_from_api) }
        .to raise_error(Exceptions::ServerError)
    end

    it 'generates random choice locally' do
      expect(described_class.new('paper').send(:computer_result)).to match(/rock|paper|scissors/)
    end
  end

  describe '#result' do
    context 'win' do
      before do
        FakeWeb.register_uri(:get,
                             'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw',
                             body: '{"body": "rock"}')
      end

      it 'returns `You won!` message' do
        expect(described_class.new('paper').result).to eq('You won! Curb with rock loses.')
      end
    end

    context 'lose' do
      before do
        FakeWeb.register_uri(:get,
                             'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw',
                             body: '{"body": "paper"}')
      end

      it 'returns `You won!` message' do
        expect(described_class.new('rock').result).to eq('You lost! Curb with paper wins.')
      end
    end

    context 'draw' do
      before do
        FakeWeb.register_uri(:get,
                             'https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw',
                             body: '{"body": "paper"}')
      end

      it 'returns `You won!` message' do
        expect(described_class.new('paper').result).to eq('Draw! Curb also chose paper.')
      end
    end
  end
end
