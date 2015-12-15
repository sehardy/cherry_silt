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

require 'cherry_silt/db'

#
module CherrySilt
  #
  class Item
    include Mixin::Mongo
    attr_accessor :short_description
    attr_accessor :long_description
    attr_accessor :name
    attr_accessor :affects
    attr_accessor :type

    def initialize(name, type)
      @name = name
      @type = type
      create_client
      @collection = @@client[:item]
      @collection.indexes.create_one({ :@name => 1, :@type => 1 }, unique: true)
      @affects = []
      find(:@name => @name, :@type => @type)
    end

    def to_s
      @short_description
    end

    def inspect
      @name
    end
  end
end
