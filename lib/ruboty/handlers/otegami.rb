require 'ruboty/actions/save_otegami'

module Ruboty
  module Handlers
    class Otegami < Base
      on(
        /save (?<otegami>.*)/,
        description: 'お手紙を受け取ります',
        name: 'otegami',
      )

      on(
        /debug dump/,
        description: 'dump for debug',
        name: 'dump',
      )

      def otegami(message)
        Ruboty::Actions::SaveOtegami.new(message).call
      end

      def dump(message)
        message.reply message.robot.brain.data[:otegami] ||= {}
      end
    end
  end
end
