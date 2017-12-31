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
        # 本来はBrainから取得する
        groups.push(::Otegami::Group.new({
          "members" => ["hisaichi5519", "hisaichi5518"],
        }))

        group = groups.find(@message.from_name)
        if group.nil?
          @message.reply "グループが見つかりませんでした"
          return
        end

        saveMessage(@message.from_name, @message.body)

        p client.chat_postMessage(
          channel: "@#{@message.from_name}",
          text: "#{group.opponent(@message.from_name)}さんへのお手紙を保存しました！編集したい場合は、また投稿してね",
          as_user: true,
          attachments: [
            {
              "fallback": "Required plain-text summary of the attachment.",
              "color": "#36a64f",
              "author_name": @message.from_name,
              "text": @message[:otegami],
              "footer": "お手紙bot"
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
        raw_groups = data[:groups] ||= []
        @groups ||= ::Otegami::Groups.new(raw_groups)
      end

      def saveMessage(name, body)
        messages = data[:messages] ||= {}
        messages[name] = body
      end

      def data
        @message.robot.brain.data[:otegami] ||= {}
      end
    end
  end
end
