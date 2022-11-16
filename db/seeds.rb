require 'open-uri'

# Team.destroy_all

# url = 'https://www.balldontlie.io/api/v1/teams'
# teams_serialized = URI.open(url).read
# teams_data = JSON.parse(teams_serialized)['data']

# ## CREATE NBA TEAMS ##

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

## CREATE GAMES ##

start_date = (Date.today - 14).strftime('%Y-%m-%d')
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
      visitor_team_id: Team.find_by(api_id: game['visitor_team']['id']).id
    )
  end
end
