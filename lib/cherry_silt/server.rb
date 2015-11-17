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
require_relative 'connection'

class Server
  attr_accessor :connections

  def initialize(ip = '127.0.0.1', port = 8081)
    @ip = ip
    @port = port
    @connections = []
  end

  def run!
    EventMachine.run do
      Signal.trap('INT') { EventMachine.stop }
      Signal.trap('TERM') { EventMachine.stop }
      EventMachine.start_server(@ip, @port, Connection) do |con|
        con.server = self
      end
    end
  end

  def post_init
    puts '-- someone connected to the echo server!'
  end

  def send_tick
    # Refresh all game data ever X seconds.
  end

  def unbind
    puts '-- someone disconnected from the echo server!'
  end
end
