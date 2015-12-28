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
  attr_accessor :login_attempts

  @@connections = []

  def initialize
    @name = nil
    @login_attempts = 0
    @player = CherrySilt::Player.new
  end

  def post_init
    send_data('Please enter your name: ')
    @@connections << self
  end

  def show_prompt
    send_data('>>> ')
  end

  def receive_data(data)
    data.strip!

    puts "Player exists? #{@player.exists?}"

    if @player.exists?
      if @player.password?
        create_user(data)
      elsif @player.authenticated?
        game_loop data
      else
        login_user data
      end
    else
      create_user data
    end
  end

  def unbind
    @player.deauthenticate!
    puts "#{@player.name} is authenticated? #{@player.authenticated}"
    @player.save!
    @@connections.delete(self)
    puts 'Bye Bye'
  end

  def login_user(data)
    puts "Login_user"
    @login_attempts += 1
    close_connection if @login_attempts > 3
    puts "Puts #{@player.name} is logging in..."
    puts @login_attempts
    if @player.verify_passwd data
      send_data "Hello #{@player.name}\n"
    else
      send_data 'password: '
    end
  end

  def create_user(data)
    puts "create_user"
    if @player.name.nil?
      puts "Setting name"
      @player.name = data
      puts "Name set to #{@player.name}"
      send_data "Enter a password for #{@player.name}: "
    else
      set_password data
    end
  end

  def set_password(data)
    puts "set_password"
    puts "Setting password #{data} for #{@player.name}"
    @player.encrypt_passwd data
    @player.verify_passwd data
    @player.save!
    send_data "Hello #{@player.name}\n"
    game_loop('look')
  end

  def game_loop(data=nil)
    send_data(Color.parse("{CThe First Room{d\n", true))
    send_data("  Okay, so this isn't really saved anywhere.  It's hard coded into connection.rb\n\n")
    send_data(show_prompt)
    parse_message(data)
  end

  def parse_message(data)
    puts "parse_message"
    send_data ">>>you sent: #{data}\n"
    case data
    when /^connections$/
      send_data("There are #{@@connections.length} connections.\n")
      show_prompt
    when /^quit$/i
      close_connection
    when /^look/i
      game_loop
    when /^color_test$/i
      send_data Color.parse("{GGreen{d\n", true)
    when /^chat (.*)$/i
      @@connections.each do |con|
        con.send_data(Color.parse("#{Regexp.last_match[1].to_s}\n", true))
        con.send_data(show_prompt)
      end
    end
  end
end
