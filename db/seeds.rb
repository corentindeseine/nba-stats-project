require 'open-uri'

# Team.destroy_all

# url = 'https://www.balldontlie.io/api/v1/teams'
# teams_serialized = URI.open(url).read
# teams_data = JSON.parse(teams_serialized)['data']

# ##### CREATE TEAMS ######

# def url_image(name)
#   "https://res.cloudinary.com/dj1mlcnes/image/upload/v1667254439/nba-project/#{name}.png"
# end

# teams_data.each do |team|
#   Team.create!(
#     name: team['full_name'],
#     abbreviation: team['abbreviation'],
#     conference: team['conference'],
#     api_id: team['id']
#   )
# end

# Team.all.each do |team|
#   team.logo.attach(io: URI.open(url_image(team.abbreviation)),
#                    filename: "#{team.abbreviation}-logo.png",
#                    content_type: 'image/png')
#   team.save!
# end

##### CREATE GAMES #####

# Game.destroy_all

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
    Game.create!(
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

url = "https://www.balldontlie.io/api/v1/stats?start_date='#{start_date}'&end_date='#{end_date}'&per_page=100"
parsing = URI.open(url).read
total_pages = JSON.parse(parsing)['meta']['total_pages']

##### CREATE PLAYERS #####

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
  end
end

##### CREATE STATS #####

for i in 1..total_pages
  url_with_page = "#{url}&page=#{i}"
  stats_serialized = URI.open(url_with_page).read
  stats = JSON.parse(stats_serialized)['data']

  stats.each do |stat|
    Stat.create(
      min: stat['min'].to_i,
      pts: stat['pts'],
      reb: stat['reb'],
      ast: stat['ast'],
      blk: stat['blk'],
      stl: stat['stl'],
      turnover: stat['turnover'],
      dreb: stat['dreb'],
      fg3_made: stat['fg3_made'],
      fg_pct: stat['fg_pct'] * 100,
      fg3_pct: stat['fg3_pct'] * 100,
      ft_pct: stat['ft_pct'] * 100,
      game_id: Game.find_by(api_id: stat['game']['id']).id,
      player_id: Player.find_by(api_id: stat['player']['id']).id
    )
  end
end
