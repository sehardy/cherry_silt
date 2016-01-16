#!/usr/bin/env ruby
##
module CherrySilt
  ##
  module CommandParser
    def self.parse!(cmd, sig)
      case cmd.length
      when 0
        "\n"
      else
        cmd = cmd.split(' ')
        begin
          puts "Command: #{cmd[0]}"
          self.private_instance_methods.find { |c| /^#{cmd}.*/i =~ c }
          send(cmd[0], cmd.drop(1), sig)
        rescue
          "There is no command #{cmd[0]}\n"
        end
      end
    end

    private

    def self.north(*args)
      "Go north.\n"
    end

    def self.south(*args)
      "Go south.\n"
    end

    def self.east(*args)
      "Go east.\n"
    end

    def self.west(*args)
      "Go west\n"
    end

    def self.up(*args)
      "Go up.\n"
    end

    def self.down(*args)
      "Go down.\n"
    end

    def self.look(*args)
      Color.parse("{CThe First Room{d\n\n  Okay, so this isn't really saved anywhere.  It's hard coded.\n\n", true)
    end

    def self.set(*args)
      "Usage: set [name|description]\n"
    end

    def self.put(*args)
      "Puts an item in the room by default\n"
    end

    def self.dig(*args)
      "Usage: dig [n|s|e|w]\nThis creates and links a new room in the direction specified\n"
    end

    def self.link(*args)
      "Usage: link [n|s|e|w] [room_uid]\nThis is used to create a link between two existing rooms at the specified direction.\n"
    end

    def self.color_test(*args)
      Color.parse("{GGreen{d\n", true)
    end

    def self.connections(*args)
      "There are #{Connection.connections.length} connections.\n"
    end

    def self.quit(*args)
      args[-1].close_connection
    end

    def self.chat(*args)
      # Strip down args
      msg = ''
      sent_from = ''

      args.each do |arg|
        if arg.is_a?(Array)
          msg = arg.join(' ')
        end
      end

      Connection.connections.each do |c|
        if c.signature == args[-1]
          sent_from = c.player.name
        end
      end

      Connection.connections.each do |con|
        if con.signature == args[-1]
          con.send_data(Color.parse("\n#{sent_from} gchats -> #{msg}\n\n", true))
        else
          con.send_data(Color.parse("\n\n#{sent_from} gchats -> #{msg}\n\n", true))
          con.send_data(con.show_prompt)
        end
      end

      return
    end
    #  @@connections.each do |con|
    #    con.send_data(Color.parse("#{Regexp.last_match[1].to_s}\n", true))
    #    con.send_data(show_prompt)
    #  end
  end
end