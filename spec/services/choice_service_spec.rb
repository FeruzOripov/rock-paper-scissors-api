require 'rails_helper'

RSpec.describe ChoiceService do
  let(:choices) { %w(rock paper scissors) }

  describe '#choices' do
    it 'returns list of choices' do
      expect(described_class.choices).to eq(choices)
    end
  end

  describe '#random_choice' do
    it 'returns random choice' do
      expect(described_class.random_choice).to match(/rock|paper|scissors/)
    end
  end
end
