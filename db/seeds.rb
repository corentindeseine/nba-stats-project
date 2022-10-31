# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Team.destroy_all

url = 'https://www.balldontlie.io/api/v1/teams'
teams_serialized = URI.open(url).read
teams_data = JSON.parse(teams_serialized)['data']

# CREATE NBA TEAMS

teams_data.each do |team|
  Team.create!(
    name: team['full_name'],
    abbreviation: team['abbreviation'],
    conference: team['conference'],
    api_id: team['id']
  )
end
