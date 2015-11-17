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

require 'digest'
require 'mongo'
require_relative 'color'

# Connection class for each user.
class Connection < EventMachine::Connection
  attr_accessor :server
  attr_accessor :logged_in
  attr_accessor :mongo_client
  attr_accessor :user_data
  attr_accessor :terminal_state
  attr_accessor :failed_attempts

  def initialize
    @name = nil
    @logged_in = nil
    @failed_attempts = 0
    @mongo_client = Mongo::Client.new(['127.0.0.1:27017'], database: 'mud')
  end

  def post_init
    send_data('Please enter your name: ')
  end

  def show_prompt
    send_data(">>> ")
  end

  def receive_data(data)
    data.strip!

    if @user_data.nil?
      fetch_user data
    elsif ! @logged_in
      login_user data
    else
      parse_message data
    end
  end

  def unbind
    @server.connections.delete(self)
  end

  def fetch_user(name)
    @user_data = @mongo_client[:users].find(name: name).first
    @user_data = {name: 'unknown_user', password: 1} if @user_data.nil?
    send_data 'password: '
  end

  def login_user(password)
    passwd_sha256 = Digest::SHA256.base64digest password
    if passwd_sha256 == @user_data[:password]
      @logged_in = true
      send_data "Hello #{user_data[:name]}\n"
      @server.connections << self
    else
      @failed_attempts += 1
      close_connection if @failed_attempts >= 3
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
