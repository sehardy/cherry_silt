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
  def self.ansi_escape(n1 = nil, n2 = nil)
    if n1.nil? && n2.nil?
      "\x1B[0m"
    elsif n2.nil?
      "\x1B[#{n1}m"
    else
      "\x1B[#{n1};#{n2}m"
    end
  end

  def self.default
    ansi_escape
  end

  def self.black
    ansi_escape(30)
  end

  def self.red
    ansi_escape(31)
  end

  def self.green
    ansi_escape(32)
  end

  def self.yellow
    ansi_escape(33)
  end

  def self.blue
    ansi_escape(34)
  end

  def self.magenta
    ansi_escape(35)
  end

  def self.cyan
    ansi_escape(36)
  end

  def self.white
    ansi_escape(37)
  end

  def self.bright_black
    ansi_escape(1, 30)
  end

  def self.bright_red
    ansi_escape(1, 31)
  end

  def self.bright_green
    ansi_escape(1, 32)
  end

  def self.bright_yellow
    ansi_escape(1, 33)
  end

  def self.bright_blue
    ansi_escape(1, 34)
  end

  def self.bright_magenta
    ansi_escape(1, 35)
  end

  def self.bright_cyan
    ansi_escape(1, 36)
  end

  def self.bright_white
    ansi_escape(1, 37)
  end

  def self.background_default
    ansi_escape(49)
  end

  def self.background_black
    ansi_escape(40)
  end

  def self.background_red
    ansi_escape(41)
  end

  def self.background_green
    ansi_escape(42)
  end

  def self.background_yellow
    ansi_escape(43)
  end

  def self.background_blue
    ansi_escape(44)
  end

  def self.background_magenta
    ansi_escape(45)
  end

  def self.background_cyan
    ansi_escape(46)
  end

  def self.background_white
    ansi_escape(47)
  end

  def self.parse_text(text)
    # Wrapper class for block notation
    yield text
  end

  def self.parse(raw_text)
    # First for this we need to establish what we're parsing
    # Generally, it would be easiest to do a {<character> notation.
    # i.e. {G would be green and {g would be bright green.
    # For background we use } instead of {
    # i.e. }g would be a green background.

    # Table is as follows:
    # ansi_escape: {d
    # black: {K
    # red: {R
    # green: {G
    # yellow: {Y
    # blue: {B
    # magenta: {M
    # cyan: {C
    # white: {W
    # bright_black: {k
    # bright_red: {r
    # bright_green: {g
    # bright_yellow: {y
    # bright_blue: {b
    # bright_magenta: {m
    # bright_cyan: {c
    # bright_white: {w
    # background_ansi_escape: }d
    # background_black: }k
    # background_red: }r
    # background_green: }g
    # background_yellow: }y
    # background_blue: }b
    # background_magenta: }n
    # background_cyan: }c
    # background_white: }w
    # Escape characters: {{ and }}

    parse_text(raw_text) do |r|
      r.gsub!('{d', "#{Color.default}")
      r.gsub!('{k', "#{Color.black}")
      r.gsub!('{r', "#{Color.red}")
      r.gsub!('{g', "#{Color.green}")
      r.gsub!('{y', "#{Color.yellow}")
      r.gsub!('{b', "#{Color.blue}")
      r.gsub!('{m', "#{Color.magenta}")
      r.gsub!('{c', "#{Color.cyan}")
      r.gsub!('{w', "#{Color.white}")
      r.gsub!('{K', "#{Color.bright_black}")
      r.gsub!('{R', "#{Color.bright_red}")
      r.gsub!('{G', "#{Color.bright_green}")
      r.gsub!('{Y', "#{Color.bright_yellow}")
      r.gsub!('{B', "#{Color.bright_blue}")
      r.gsub!('{M', "#{Color.bright_magenta}")
      r.gsub!('{C', "#{Color.bright_cyan}")
      r.gsub!('{W', "#{Color.bright_white}")
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
