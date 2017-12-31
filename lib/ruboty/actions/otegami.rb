require 'slack'


Slack.configure do |config|
  config.token = ENV["SLACK_TOKEN"]
end

module Ruboty
  module Actions
    class Otegami < Base
      def initialize(message)
        @message = message
      end

      def call
        if @message.from_name == "testapp"
          return
        end

        groups.push(::Otegami::Group.new(["hisaichi5519", "hisaichi5518"]))

        group = groups.find(@message.from_name)

        p client.chat_postMessage(
          channel: "@#{@message.from_name}",
          text: "#{group.opponent(@message.from_name)}さんへのお言葉を保存しました！編集したい場合は、また投稿してね",
          as_user: true,
          attachments: [
            {
              "fallback": "Required plain-text summary of the attachment.",
              "color": "#36a64f",
              "author_name": @message.from_name,
              "text": @message.body,
              "footer": "お言葉bot"
            }
          ]
        )
      end

      private
      def client
        @client ||= Slack::Client.new
      end

      def groups
        # [{members: ["hisaichi5518", "hisaichi5519"], hisaichi5518: "", ...}, ...]
        raw_groups = @message.robot.brain.data[:otegami__groups] ||= []
        @groups ||= ::Otegami::Groups.new(raw_groups)
      end
    end
  end
end
