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

require 'yaml'

#
module CherrySilt
  #
  module Config
    extend self

    @_settings = {}
    attr_reader :_settings

    def load!(filename, options = {})
      newsets = YAML::load_file(filename)
      deep_merge!(@_settings, newsets)
    end

    def deep_merge!(target, data)
      merger = proc{|key, v1, v2|
        Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2}
      target.merge! data, &merger
    end

    def method_missing(name, *args, &block)
      @_settings[name.to_s] ||
        fail(NoMethodError, "unknown configuration root #{name}", caller)
    end
  end
end
