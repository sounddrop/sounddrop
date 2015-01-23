# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  
  
   story1 = Story.create(sc_track:"187471639")
   story2 = Story.create(sc_track:"187472172")
   story3 = Story.create(sc_track:"187472038")
   Place.create(name: "@SoundCloud HQ", story_id: story1.id)
   Place.create(name: "@SoundCloud HQ", story_id: story2.id)
   Place.create(name: "@SoundCloud HQ", story_id: story3.id)