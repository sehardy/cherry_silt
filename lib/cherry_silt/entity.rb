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

##
module CherrySilt
  ##
  class Entity
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def ==(other)
      self.instance_of?(other) &&
        other.name == @name &&
        other.long_name == @long_name
    end

    alias_method :eql?, :==

    def self.from_h(h)
      entity = allocate
      entity.name = h['name']
      entity.long_name = h['long_name'] if h.key?('long_name')
      entity
    end

    def to_h
      { name: @name, long_name: @long_name }
    end

    def hash
      @name.hash ^ @long_name.hash # not sure this is best
    end
  end
end
