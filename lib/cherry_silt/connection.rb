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

# Connection class for each player

class Connection < EventMachine::Connection
	attr_accessor :server
	attr_accessor :name
	attr_accessor :password

	def initialize
		@name = nil
		@password = nil
	end

  def post_init
    send_data("Please enter your name: ")
  end

  def receive_data(data)
    data.strip!

    if @name.nil?
      login_user
    else 
      parse_message
    end  
  end

  def login_user(name)
    send_data("Hello #{name}")
  end
  
  def parse_message(data)
    send_data("You said: #{data}")
  end

end



