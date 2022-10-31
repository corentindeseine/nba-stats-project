require 'open-uri'

Team.destroy_all

url = 'https://www.balldontlie.io/api/v1/teams'
teams_serialized = URI.open(url).read
teams_data = JSON.parse(teams_serialized)['data']

# CREATE NBA TEAMS

def url_image(name)
  "https://res.cloudinary.com/dj1mlcnes/image/upload/v1667254439/nba-project/#{name}.png"
end

teams_data.each do |team|
  Team.create!(
    name: team['full_name'],
    abbreviation: team['abbreviation'],
    conference: team['conference'],
    api_id: team['id']
  )
end

Team.all.each do |team|
  team.logo.attach(io: URI.open(url_image(team.abbreviation)),
                   filename: "#{team.abbreviation}-logo.png",
                   content_type: 'image/png')
  team.save!
end
