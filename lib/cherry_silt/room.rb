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

require 'bson'
require 'json'
require 'mongo'

# Room class
class Room
  attr_accessor :description
  attr_accessor :name
  attr_accessor :exits
  attr_accessor :contents
  attr_accessor :type
  attr_reader :uid

  def initialize
    # Create a generic room with UID 1 to start with.
    # Other rooms will derive their UID from mongo's _id attribute.
    @name = 'A blank room'
    @description = 'There is nothing here'
    @exits = []
    @contents = []
    @type = :exterior
    @uid = 1
  end

  def save
    client = Mongo::Client.new(['127.0.0.1:27017'], database: 'mud')
    # Check to see if uid exists already (minus Room.UID 1), if it does, update the values.
    # If it doesn't, do something similar to below:
    if @uid == 1
      @uid = nil
      result = client[:rooms].insert_one(to_h)
      @uid = JSON.parse(result.inserted_id.to_json['$oid'])
      Room.load(@uid)
    else
      result = client[:rooms].find_one_and_update({_id: @uid}, to_h, return_document: :after)
      from_h(result)
    end

    client.close
  end

  def self.load(uid)
    # Class level method to load rooms.
    # Used to load objects from mongoDB into memory

    # This may need to go up to class level instead of repeating a second time.
    client = Mongo::Client.new(['127.0.0.1:27017'], database: 'mud')
    client[:rooms].find(_id: BSON::ObjectId(uid)).each do |room|
      self.from_h(room)
    end
  end

  def to_s
    # This will need to be updated more later for displaying multiple items.
    # Either that or that can be taken care of when items are added to the
    # contents.
    # i.e. ( 2) A rolled up map is here.
    #      (19) A tankard of cool, dark ale is here.
    "#{@name}\n#{@description}\n\n#{@contents}\n\n"
  end

  def to_h
    { name: @name, description: @description, exits: @exits,
     conents: @contents, type: @type,
     _id: @id}.delete_if { |k,v| v.nil? }
  end

  def from_h(h)
    @name = h[:name]
    @description = h[:description]
    @exits = h[:exits]
    @contents = h[:contents]
    @type = h[:type].to_sym
    @uid = h[:_id]
  end

  def inspect
    # Probably not needed.  When a player issues a 'look' command it will run
    # the to_s function inside of either the player class or the connection
    # class.  Leaving for now.
    @description
  end
end
