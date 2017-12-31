require 'slack'

module Ruboty
  module Actions
    class SaveOtegami < Base
      def initialize(message)
        @message = message
      end

      def call
        group = groups.find(@message.from_name)
        if group.nil?
          @message.reply "今回はお手紙を送る相手がいません…"
          return
        end

        save_message(@message.from_name)

        p client.chat_postMessage(
          channel: "@#{@message.from_name}",
          text: "#{group.opponent(@message.from_name)}さんへのお手紙を保存しました！編集したい場合は、また投稿してね",
          as_user: true,
          attachments: [
            {
              "fallback": "「#{body}}」",
              "color": "#36a64f",
              "author_name": @message.from_name,
              "text": body,
              "footer": "お手紙bot"
            }
          ]
        )
      end

      private
      def client
        @client ||= Slack::Client.new
      end

      def body
        @message[:otegami]
      end

      def groups
        @groups ||= ::Otegami::Groups.new(data[:groups] ||= [])
      end

      def save_message(name)
        messages = data[:messages] ||= {}
        messages[name] = body
      end

      def data
        @message.robot.brain.data[:otegami] ||= {}
      end
    end
  end
end
