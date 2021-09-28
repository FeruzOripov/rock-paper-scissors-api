class ChoiceService
  CHOICES = ['rock', 'paper', 'scissors']

  def self.choices
    CHOICES
  end

  def self.random_choice
    CHOICES.sample
  end
end
