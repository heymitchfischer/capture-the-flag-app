json.array! @players.each do |player|
  json.id player.id
  json.name player.name
  json.team_id player.team_id
  json.points player.points
  json.has_flag player.has_flag
  json.time_stunned player.time_stunned
end