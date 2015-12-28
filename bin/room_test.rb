#!/usr/bin/env ruby

require 'mongo'
require 'cherry_silt'


Mongo::Logger.logger.level = Logger::WARN

def load_rooms
  puts 'Creating initial room'
  init_room = CherrySilt::Room.new
  init_room.save!
  puts 'Listing initial collection.'
  puts init_room.find(name: /.*/)

  puts 'Creating a new room.'
  test_room = CherrySilt::Room.new

  puts 'Modifying room'
  test_room.name = 'Test Room'
  test_room.description = '  A room created from room_test'

  puts 'Saving modified room'
  test_room.save!

  puts 'Listing rooms'
  puts test_room.collection.find(name: /.*/).each { |r| puts r }
end

# Main
if __FILE__ == $0
  load_rooms
end