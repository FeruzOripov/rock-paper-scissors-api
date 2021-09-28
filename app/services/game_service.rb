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
    @choice == @computer_choice
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
