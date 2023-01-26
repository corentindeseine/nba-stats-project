class PlayersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @players = Player.all
  end

  def show
    @player = Player.find(params[:id])
    render json: @player.to_json(include: %i[team stats])
  end
end
