require 'rake'
require_relative '../../config/environment.rb'

class DailyImportWorker
  include Sidekiq::Worker

  def perform
    p'************************************************************'
    Rake::Task['nba:import_games_and_stats'].invoke(calculate_start_date)
  end

  private

  def calculate_start_date
    # Logique pour obtenir la date à partir de laquelle récupérer les valeurs
    last_game = Game.order(date: :desc).first
    last_game.present? ? last_game.date : Date.today
  end
end
