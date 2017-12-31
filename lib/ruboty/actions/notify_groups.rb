require 'slack'

module Ruboty
  module Actions
    class NotifyGroups < Base
      def initialize(message)
        @message = message
      end

      def call
        config = ::Otegami::Config.new

        config.members.shuffle!

        raw_groups = data[:groups] = []

        while config.members.size > 0 do
          group = config.members.slice!(0, 2)
          if group.size == 1
            if raw_groups[-1].nil?
              # グループに1人しかいないけど、グループがないということは
              # 1人しか設定されていないということ
              @message.reply "メンバーが1人しか設定されていません"
              return
            else
              # 人間が余っていたら最後のグループに追加する
              raw_groups[-1] |= group
            end
          else
            raw_groups.push(group)
          end

          send_message(group)
        end

        @message.reply data
      end

      private
      def client
        @client ||= Slack::Client.new
      end

      def data
        @message.robot.brain.data[:otegami] ||= {}
      end

      def send_message(group)
        group.each do |member|
          p client.chat_postMessage(
            channel: "@#{member}",
            text: "今月は、 @#{::Otegami::Group.new(group).opponent(member)} さんにお手紙を送ってください！",
            as_user: true,
          )
        end
      end
    end
  end
end
