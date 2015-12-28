#!/usr/bin/env ruby

module CommandParser
  @@commands = %w( north south east west up down look set put dig link )

  def self.parse!(cmd)
    case @@commands.find { |c| /^#{cmd}/ =~ c }
    when 'north'
      puts 'Go north.'
    when 'south'
      puts 'Go south.'
    when 'east'
      puts 'Go east.'
    when 'west'
      puts 'Go west.'
    when 'up'
      puts 'Go up.'
    when 'down'
      puts 'Go down.'
    when 'look'
      puts 'Look at current room.'
    when 'set'
      puts 'Usage: set [name|description]'
    when 'put'
      puts 'Puts an item in the room by default'
    when 'dig'
      puts 'Usage: dig [n|s|e|w]'
      puts 'This creates and links a new room in the direction specified'
    when 'link'
      puts 'Usage: link [n|s|e|w] [room_uid]'
      puts 'This is used to create a link between two existing rooms at the specified direction.'
    else
      puts "There is no such command as \"#{cmd}\""
    end
  end
end

puts 'Enter Command:'
cmd = gets.chomp

CommandParser.parse!(cmd)
