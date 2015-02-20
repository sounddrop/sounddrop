# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  
    sc_place = Place.create!(name: "@SoundCloud HQ")
    sc_place = Place.create!(name: "@SoundCloud SF")
    sc_place = Place.create!(name: "@SoundCloud NY")

    story1 = Story.create!(sc_track:"187471639", place_id:"1", title:"Coffee Machine")
    story2 = Story.create!(sc_track:"187472172", place_id:"1", title: "Brewing Coffee for engineers")
    story3 = Story.create!(sc_track:"187472038", place_id:"1", title: "Art installation")

