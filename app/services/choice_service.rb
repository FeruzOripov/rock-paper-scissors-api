class ChoiceService
  CHOICES = %w(rock paper scissors).freeze

  def self.choices
    CHOICES
  end

  def self.random_choice
    CHOICES.sample
  end
end
