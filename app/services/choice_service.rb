class ChoiceService
  CHOICES = ['rock', 'paper', 'scissor']

  def self.choices
    CHOICES
  end

  def self.random_choice
    CHOICES.sample
  end
end
