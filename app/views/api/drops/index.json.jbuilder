json.array! @drops do |drop|
  json.id drop.id
  json.title drop.title
  json.sc_track drop.sc_track
  json.place do
    json.id drop.place.id
    json.name drop.place.name
    json.latitude drop.place.latitude
    json.longitude drop.place.longitude
  end
end
