require 'ruboty/actions/otegami'

module Ruboty
  module Handlers
    class Otegami < Base
      on(
        /.*/,
        description: 'お言葉を受け取ります',
        name: 'otegami',
        all: true
      )

      on(
        /dump/,
        description: 'dump for debug',
        name: 'dump',
      )

      def otegami(message)
        Ruboty::Actions::Otegami.new(message).call
      end

      def dump(message)
        message.reply message.robot.brain.data[:otegami]
      end
    end
  end
end
