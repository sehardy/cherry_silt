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

module Color
  def Color.normal
    "\x1B[0m"
  end

  def Color.black
    "\x1B[0;30m"
  end

  def Color.red
    "\x1B[0;31m"
  end

  def Color.green
    "\x1B[0;32m"
  end

  def Color.yellow 
    "\x1B[0;33m"
  end

  def Color.blue 
    "\x1B[0;34m"
  end

  def Color.magenta
    "\x1B[0;35m"
  end

  def Color.cyan 
    "\x1B[0;36m"
  end

  def Color.white 
    "\x1B[0;37m"
  end

  def Color.dark_black
    "\x1B[1;30m"
  end

  def Color.dark_red 
    "\x1B[1;31m"
  end

  def Color.dark_green
    "\x1B[1;32m"
  end

  def Color.dark_yellow 
    "\x1B[1;33m"
  end

  def Color.dark_blue
    "\x1B[1;34m"
  end

  def Color.dark_magenta 
    "\x1B[1;35m"
  end

  def Color.dark_cyan 
    "\x1B[1;36m"
  end

  def Color.dark_white 
    "\x1B[1;37m"
  end

  def Color.background_black 
    "\x1B[40m"
  end

  def Color.background_red 
    "\x1B[41m"
  end

  def Color.background_green 
    "\x1B[42m"
  end

  def Color.background_yellow 
    "\x1B[43m"
  end

  def Color.background_blue 
    "\x1B[44m"
  end

  def Color.background_magenta 
    "\x1B[45m"
  end

  def Color.background_cyan 
    "\x1B[46m"
  end

  def Color.background_white 
    "\x1B[47m"
  end
end