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

require 'mongo'

##
module CherrySilt
  ##
  module Mixin
    ##
    module Mongo
      @@client = nil
      attr_accessor :collection
      attr_accessor :uid

      def create_client
        # should load database settings from yaml file
        @@client ||= ::Mongo::Client.new(['127.0.0.1:27017'], database: 'mud')
      end

      def save!
        create_client
        document = to_h
        if @uid.nil?
          result = @collection.insert_one document
          @uid = result.inserted_id
        else
          document[:_uid] = @uid
          @collection.find_one_and_update({ _id: @uid },
                                          return_document: :after)
        end
      end

      def to_h
        h = {}
        instance_variables.each do |var_name|
          next if var_name == :@collection || var_name == :@uid
          h[var_name] = instance_variable_get(var_name)
        end
        h
      end

      def find(query)
        create_client
        result = @collection.find(query).first
        return if result.nil?
        @uid = result[:_id]
        result.each do |key, value|
          next if key.to_sym == :_id
          instance_variable_set(key.to_sym, value)
        end
      end

      private :create_client, :collection
    end
  end
end
