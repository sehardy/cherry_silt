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

Mongo::Logger.logger.level = Logger::WARN

# Connection class for each user.
class Connection < EventMachine::Connection
  attr_accessor :server
  attr_accessor :player
  attr_accessor :state
  attr_accessor :login_attempts

  @@connections = []

  def initialize
    @name = nil
    @login_attempts = 0
    @player = CherrySilt::Player.new
    @state = :new_connection
  end

  def post_init
    send_data('Please enter your name: ')
    @state = :checking_user
    @@connections << self
  end

  def show_prompt
    '>>> '
  end

  def receive_data(data)
    data.strip!

    case @state
    when :checking_user
      @player.name = data
      if !@player.exists?
        @state = :creating_user
        send_data "Create a password for #{@player.name}: "
      else
        @state = :authenticating_user
        send_data "Please enter password for #{@player.name}: "
      end
    when :creating_user
      create_user data
      @state = :playing
    when :authenticating_user
      login_user data
    when :playing
      game_loop data
    else
      send_data 'How the hell did you get here?'
    end
  end

  def unbind
    @player.deauthenticate!
    @player.save!
    @@connections.delete(self)
    puts 'Bye Bye'
  end

  def login_user(data)
    @login_attempts += 1
    close_connection if @login_attempts > 3
    puts @login_attempts
    if @player.verify_passwd data
      send_data "Hello #{@player.name}\n"
      @state = :playing
      send_data show_prompt
    else
      send_data "Incorrect password.  You have #{3-login_attempts} attempts remaining.\n"
      send_data 'Password: '
    end
  end

  def create_user(data)
    puts "Creating user"
    set_password data
    @player.save!
    @player.verify_passwd data

  end

  def set_password(data)
    @player.encrypt_passwd data
  end

  def look(data=nil)
    send_data(Color.parse("{CThe First Room{d\n", true))
    send_data("  Okay, so this isn't really saved anywhere.  It's hard coded into connection.rb\n\n")
  end

  def game_loop(data)
    case data
    when ''
      send_data "\n"
    when /^connections$/
      send_data "There are #{@@connections.length} connections.\n"
    when /^quit$/i
      close_connection
    when /^look/i
      look
    when /^color_test$/i
      send_data Color.parse("{GGreen{d\n", true)
    when /^chat (.*)$/i
      @@connections.each do |con|
        con.send_data(Color.parse("#{Regexp.last_match[1].to_s}\n", true))
        con.send_data(show_prompt)
      end
    else
      send_data "I'm sorry, I do not know what #{data} is.\n"
    end
    send_data show_prompt
  end
end
