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

# ANSI color mapping
module Color
  def self.default
    "\x1B[0m"
  end

  def self.black
    "\x1B[0;30m"
  end

  def self.red
    "\x1B[0;31m"
  end

  def self.green
    "\x1B[0;32m"
  end

  def self.yellow
    "\x1B[0;33m"
  end

  def self.blue
    "\x1B[0;34m"
  end

  def self.magenta
    "\x1B[0;35m"
  end

  def self.cyan
    "\x1B[0;36m"
  end

  def self.white
    "\x1B[0;37m"
  end

  def self.dark_black
    "\x1B[1;30m"
  end

  def self.dark_red
    "\x1B[1;31m"
  end

  def self.dark_green
    "\x1B[1;32m"
  end

  def self.dark_yellow
    "\x1B[1;33m"
  end

  def self.dark_blue
    "\x1B[1;34m"
  end

  def self.dark_magenta
    "\x1B[1;35m"
  end

  def self.dark_cyan
    "\x1B[1;36m"
  end

  def self.dark_white
    "\x1B[1;37m"
  end

  def self.background_default
    "\x1B[49m"
  end

  def self.background_black
    "\x1B[40m"
  end

  def self.background_red
    "\x1B[41m"
  end

  def self.background_green
    "\x1B[42m"
  end

  def self.background_yellow
    "\x1B[43m"
  end

  def self.background_blue
    "\x1B[44m"
  end

  def self.background_magenta
    "\x1B[45m"
  end

  def self.background_cyan
    "\x1B[46m"
  end

  def self.background_white
    "\x1B[47m"
  end

  def self.parse_text(text)
    # Wrapper class for block notation
    yield text
  end

  def self.parse(raw_text)
    # First for this we need to establish what we're parsing
    # Generally, it would be easiest to do a {<character> notation.
    # i.e. {G would be green and {g would be dark green.
    # For background we use } instead of {
    # i.e. }g would be a green background.

    # Table is as follows:
    # default: {d
    # black: {K
    # red: {R
    # green: {G
    # yellow: {Y
    # blue: {B
    # magenta: {M
    # cyan: {C
    # white: {W
    # dark_black: {k
    # dark_red: {r
    # dark_green: {g
    # dark_yellow: {y
    # dark_blue: {b
    # dark_magenta: {m
    # dark_cyan: {c
    # dark_white: {w
    # background_default: }d
    # background_black: }k
    # background_red: }r
    # background_green: }g
    # background_yellow: }y
    # background_blue: }b
    # background_magenta: }n
    # background_cyan: }c
    # background_white: }w

    self.parse_text(raw_text) do |r|
      r.gsub!('{d', "#{Color.default}")
      r.gsub!('{K', "#{Color.black}")
      r.gsub!('{R', "#{Color.red}")
      r.gsub!('{G', "#{Color.green}")
      r.gsub!('{Y', "#{Color.yellow}")
      r.gsub!('{B', "#{Color.blue}")
      r.gsub!('{M', "#{Color.magenta}")
      r.gsub!('{C', "#{Color.cyan}")
      r.gsub!('{W', "#{Color.white}")
      r.gsub!('{k', "#{Color.dark_black}")
      r.gsub!('{r', "#{Color.dark_red}")
      r.gsub!('{g', "#{Color.dark_green}")
      r.gsub!('{y', "#{Color.dark_yellow}")
      r.gsub!('{b', "#{Color.dark_blue}")
      r.gsub!('{m', "#{Color.dark_magenta}")
      r.gsub!('{c', "#{Color.dark_cyan}")
      r.gsub!('{w', "#{Color.dark_white}")
      r.gsub!('}d', "#{Color.background_default}")
      r.gsub!('}k', "#{Color.background_black}")
      r.gsub!('}r', "#{Color.background_red}")
      r.gsub!('}g', "#{Color.background_green}")
      r.gsub!('}y', "#{Color.background_yellow}")
      r.gsub!('}b', "#{Color.background_blue}")
      r.gsub!('}n', "#{Color.background_magenta}")
      r.gsub!('}c', "#{Color.background_cyan}")
      r.gsub!('}w', "#{Color.background_white}")
    end

    raw_text
  end
end
