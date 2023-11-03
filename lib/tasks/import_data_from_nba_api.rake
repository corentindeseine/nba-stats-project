require 'open-uri'
require "nokogiri"

require_relative '../nba_utils'
require_relative '../players_data'

namespace :nba do
  desc "Import NBA team data from API"
  task import_teams: :environment do
    url = 'https://www.balldontlie.io/api/v1/teams'
    teams_serialized = URI.open(url).read
    teams_data = JSON.parse(teams_serialized)['data']

    teams_data.each do |team|
      Team.create!(
        name: team['full_name'],
        abbreviation: team['abbreviation'],
        conference: team['conference'],
        api_id: team['id']
      )
    end

    Team.all.each do |team|
      team.logo.attach(
        io: URI.open("https://res.cloudinary.com/dj1mlcnes/image/upload/v1667254439/nba-project/#{team.abbreviation}.png"),
        filename: '#{team.abbreviation}-logo.png',
        content_type: 'image/png'
      )
      team.save
    end
    p "All nba teams are imported"
  end

  desc "Import NBA player data from API"
  task import_players: :environment do
    start_date = (Date.today - 24).strftime('%Y-%m-%d')
    end_date = Time.now.strftime('%Y-%m-%d')
    url = "https://www.balldontlie.io/api/v1/stats?start_date='#{start_date}'&end_date='#{end_date}'&per_page=100"
    parsing = URI.open(url).read
    total_pages = JSON.parse(parsing)['meta']['total_pages']

    for i in 1..total_pages
      url_with_page = "#{url}&page=#{i}"
      players_serialized = URI.open(url_with_page).read
      players = JSON.parse(players_serialized)['data']

      players.each do |player|
        player = player['player']
        Player.create(
          api_id: player['id'],
          first_name: player['first_name'],
          last_name: player['last_name'],
          position: player['position'],
          team_id: Team.find_by(api_id: player['team_id']).id
        )
        p player
      end
    end
    p "All nba players are imported"
  end

  desc "Avatar player scrapping"
  task import_players_avatar: :environment do
    active_players = PLAYERS.reject { |player| player[4] == false }

    active_players.each do |player|
      # PARSING IMAGE FROM NBA WEBSITE
      url = "https://www.nba.com/player/#{player[0]}"
      begin
        p player[3]
        html_file = URI.open(url).read
      rescue OpenURI::HTTPError => error
        if error.message == '502 Bad Gateway' || error.message == '500 Internal Server Error'
          next
        else
          raise error
        end
      end
      html_doc = Nokogiri::HTML(html_file)
      element = html_doc.search('.PlayerImage_image__wH_YX')[0]
      image_url = element.attributes['src'].text

      selected_player = Player.find_by(first_name: player[2], last_name: player[1])
      unless selected_player.nil?
        selected_player.image_url = image_url
        selected_player.save!
      end
    end
  end

  desc "Import games data from API"
  task import_games_from_last_month: :environment do
    start_date = (Date.today - 24).strftime('%Y-%m-%d')
    end_date = Time.now.strftime('%Y-%m-%d')

    url = "https://www.balldontlie.io/api/v1/games?start_date='#{start_date}'&end_date='#{end_date}'&per_page=100"
    parsing = URI.open(url).read
    total_pages = JSON.parse(parsing)['meta']['total_pages']

    for i in 1..total_pages
      url_with_page = "#{url}&page=#{i}"
      games_serialized = URI.open(url_with_page).read
      games = JSON.parse(games_serialized)['data']

      games.each do |game|
        Game.create(
          date: game['date'].split('').first(10).join,
          period: game['period'],
          home_team_score: game['home_team_score'],
          visitor_team_score: game['visitor_team_score'],
          home_team_id: Team.find_by(api_id: game['home_team']['id']).id,
          visitor_team_id: Team.find_by(api_id: game['visitor_team']['id']).id,
          api_id: game['id']
        )
      end
    end
    p "All games are imported"
  end

  desc "Import stats data from API"
  task import_stats_from_last_month: :environment do
    start_date = (Date.today - 24).strftime('%Y-%m-%d')
    end_date = Time.now.strftime('%Y-%m-%d')
    url = "https://www.balldontlie.io/api/v1/stats?start_date='#{start_date}'&end_date='#{end_date}'&per_page=100"
    parsing = URI.open(url).read
    total_pages = JSON.parse(parsing)['meta']['total_pages']

    for i in 1..total_pages
      url_with_page = "#{url}&page=#{i}"
      stats_serialized = URI.open(url_with_page).read
      stats = JSON.parse(stats_serialized)['data']

      stats.each do |stat|
        Stat.create(
          api_id: stat['id'],
          min: stat['min'].to_i,
          pts: stat['pts'],
          reb: stat['reb'],
          ast: stat['ast'],
          blk: stat['blk'],
          stl: stat['stl'],
          turnover: stat['turnover'],
          dreb: stat['dreb'],
          fg3_made: stat['fg3m'],
          fg_pct: stat['fg_pct'] * 100,
          fg3_pct: stat['fg3_pct'] * 100,
          ft_pct: stat['ft_pct'] * 100,
          game_id: Game.find_by(api_id: stat['game']['id']).id,
          player_id: Player.find_by(api_id: stat['player']['id']).id,
          rating: stat['pts'] +
                  stat['ast'] * 1.5 +
                  stat['reb'] * 1.2 +
                  stat['blk'] * 3 +
                  stat['stl'] * 3 -
                  stat['turnover'] * 2 +
                  stat['fg3m'] +
                  triple_or_double_double(stat['pts'], stat['ast'], stat['reb'], stat['blk'], stat['stl'])
        )
      end
    end

    p "All games are imported"
  end
end
