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

##
module CherrySilt
  ##
  class Player < Entity
    attr_accessor :title
    attr_accessor :password
    attr_accessor :authenticated

    def initialize(name)
      super name
    end

    def ==(other)
      self.instance_of?(other) &&
        other.title == @title &&
        other.password == @password
    end

    alias_method :eql?, :==

    def to_h
      { title: @title, password: @password }.merge super.to_h
    end

    def self.from_h(h)
      player = super h
      player.title = h['title']
      player.password = h['password']
      player
    end

    def hash
      @title.hash ^ @password.hash ^ super.hash # not sure this is best
    end

    def generate_salt
      ('"'..'~').to_a.sample(8).join
    end

    def verify_passwd(passwd)
      salt, enc = @password.split '!'
      @authenticated = enc == Digest::SHA256.hexdigest("#{salt}!#{passwd}")
    end

    def encrypt_passwd(passwd)
      salt = generate_salt
      enc = Digest::SHA256.hexdigest "#{salt}!#{passwd}"
      @password = "#{salt}!#{enc}"
    end
  end
end
