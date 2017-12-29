require 'slack'


Slack.configure do |config|
  config.token = ENV["SLACK_TOKEN"]
end

module Ruboty
  module Actions
    class Okotoba < Base
      def initialize(message)
        @message = message
      end

      def call
        if @message.from_name == "testapp"
          return
        end


        p client.chat_postMessage(
          channel: "@#{@message.from_name}",
          text: 'ほげほげさんへのお言葉、保存しました！編集したい場合は、また投稿してね',
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
    end
  end
end
