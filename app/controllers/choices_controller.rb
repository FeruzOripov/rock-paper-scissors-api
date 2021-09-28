class ChoicesController < ApplicationController
  rescue_from ::Exceptions::InvalidChoice do |e|
    render json: 'invalid choice', status: 400
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: 'choice is missing or the value is empty', status: 400
  end

  def index
    render json: list_of_choices, status: :ok
  end

  def result
    render json: GameService.new(choices_params).result, status: :ok
  end

  private

  def list_of_choices
    ChoiceService.choices
  end

  def choices_params
    params.require(:choice)
  end
end
