require 'uri'
require 'net/http'

class GameService
  attr_accessor :choice, :computer_choice

  URL = URI('https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw')

  def initialize(choice)
    @choice = check_choice(choice)
    @computer_choice ||= get_computer_choice
  end

  def result
    if (@choice == 'rock' && @computer_choice == 'scissors') ||
      (@choice == 'scissors' && @computer_choice == 'paper') ||
      (@choice == 'paper' && @computer_choice == 'rock')
      "You won! Curb with #{@computer_choice} loses."
    elsif @choice == @computer_choice
      "Draw! Curb also chose #{computer_choice}."
    else
      "You lost! Curb with #{@computer_choice} wins."
    end
  end

  private

  def get_result_from_api
    response = Net::HTTP.get_response(URL)
    if response.code == '500'
      raise ::Exceptions::ServerError
    else
      JSON.parse(response.body)['body']
    end
  end

  def get_computer_choice
    begin
      get_result_from_api
    rescue ::Exceptions::ServerError
      ChoiceService.random_choice
    end
  end

  def check_choice(choice)
    if ChoiceService.choices.include?(choice)
      choice
    else
      raise ::Exceptions::InvalidChoice
    end
  end
end
