require 'ruboty/actions/save_otegami'
require 'ruboty/actions/notify_groups'
require 'ruboty/actions/notify_result'

module Ruboty
  module Handlers
    class Otegami < Base
      on(
        /save (?<otegami>.*)/,
        description: 'お手紙を受け取ります',
        name: 'otegami',
      )

      on(
        /notify groups/,
        description: 'お手紙を送り合うグループを通知します',
        name: 'notify_groups',
      )

      on(
        /notify result/,
        description: '結果を通知します',
        name: 'notify_result',
      )

      on(
        /dump/,
        description: 'dump for debug',
        name: 'dump',
      )

      def otegami(message)
        Ruboty::Actions::SaveOtegami.new(message).call
      end

      def notify_groups(message)
        Ruboty::Actions::NotifyGroups.new(message).call
      end

      def notify_result(message)
        Ruboty::Actions::NotifyResult.new(message).call
      end

      def dump(message)
        message.reply message.robot.brain.data[:otegami] ||= {}
      end
    end
  end
end
