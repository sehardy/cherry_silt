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

require 'json'

#
module CherrySilt
  #
  class Room
    include Mixin::Mongo
    attr_accessor :description
    attr_accessor :name
    attr_accessor :exits
    attr_accessor :contents
    attr_accessor :type
    attr_accessor :collection
    attr_accessor :area

    def initialize
      @name = 'A blank room'
      @description = '  There is nothing here'
      @exits = { N: '', S: '', E: '', W: '', U: '', D: '' }
      @contents = []
      @type = :exterior
      create_client
      @collection = @@client[:rooms]
      @uid = nil
      @area = ''
    end

    def to_s
      # This will need to be updated more later for displaying multiple items.
      # Either that or that can be taken care of when items are added to the
      # contents.
      # i.e. ( 2) A rolled up map is here.
      #      (19) A tankard of cool, dark ale is here.
      if @contents.length > 0
        "#{@name}\n#{@description}\n\n#{@contents}\n\n"
      else
        "#{@name}\n#{@description}\n\n"
      end
    end
  end
end
