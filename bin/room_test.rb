#!/usr/bin/env ruby

require 'mongo'
require 'cherry_silt'


Mongo::Logger.logger.level = Logger::WARN

def load_rooms
  init_room = CherrySilt::Room.new
  init_room.save!
  puts init_room.find(name: init_room.name)[:_id].nil?
  test_room = CherrySilt::Room.new
  test_room.name = 'Test Room'
  test_room.description = '  A room created from room_test'
  test_room.save!

  printf init_room.to_s
  printf test_room.to_s
end

# Main
if __FILE__ == $0
  load_rooms
end