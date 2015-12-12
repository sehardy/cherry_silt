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
require 'cherry_silt'

# Connection class for each user.
class Connection < EventMachine::Connection
  attr_accessor :server
  attr_accessor :player
  attr_accessor :login_attempts

  def initialize
    @name = nil
    @login_attempts = 0
  end

  def post_init
    send_data('Please enter your name: ')
  end

  def show_prompt
    send_data('>>> ')
  end

  def receive_data(data)
    data.strip!

    if @player.nil?
      fetch_user data
    elsif ! @player.authenticated
      login_user data
    else
      parse_message data
    end
  end

  def unbind
    puts 'Bye Bye'
    # this doesn't seem to be dropping connection
    @server.connections.delete(self)
  end

  def fetch_user(name)
    @player = CherrySilt::Player.load name
    send_data 'password: '
  end

  def login_user(password)
    @login_attempts += 1
    unbind if @login_attempts > 3
    puts @login_attempts
    if @player.verify_passwd password
      send_data "Hello #{@player.name}\n"
    else
      send_data 'password: '
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
