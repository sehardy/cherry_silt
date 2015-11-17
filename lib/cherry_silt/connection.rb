# Cherry Silt -- MUD written in ruby using eventmachine
# Copyright (C) 2015 Sean Hardy

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'eventmachine'
require 'mongo'
require_relative 'color'

# Connection class for each player
class Connection < EventMachine::Connection
  attr_accessor :server
  attr_accessor :name
  attr_accessor :password

  def initialize
    @name = nil
    @password = nil
    @client = Mongo::Client.new(['127.0.0.1:27017'], database: 'mud')
  end

  def create_user(name)
    send_data("#{Color.cyan}Hello #{name}!\n")
    send_data("We don't really have things set up to create a character\n")
    send_data("right now so fuck it, you're just you.\n")
    send_data("We'll just get you added to the database and send you on your way.\n")
    @client[:players].insert_one(name: "#{name}")
    @name = name
    send_data("There!  You're in!  Unfortunately you have no stats, no class,\n")
    send_data("no race...nothing.  You're basically\n")
    send_data("an amorphous blob...sooooo....have fun.#{Color.normal}\n")
    show_prompt
  end

  def post_init
    send_data('Please enter your name: ')
  end

  def show_prompt
    send_data(">>> ")
  end

  def receive_data(data)
    data.strip!

    if @name.nil?
      login_user(data)
    else
      parse_message(data)
    end
  end

  def unbind
    @server.connections.delete(self)
  end

  def login_user(name)
    @server.connections << self

    case @client[:players].find(name: "#{name}").count
    when 0
      create_user(name)
    when 1
      send_data("Hello #{name}\n")
      @name = name
      show_prompt
    end
  end

  def parse_message(data)
    send_data ">>>you sent: #{data}\n"
    case data
    when /^connections$/
      send_data("There are #{@server.connections.length} connections.\n")
      show_prompt
    when /^quit$/i
      close_connection
    end
  end
end
