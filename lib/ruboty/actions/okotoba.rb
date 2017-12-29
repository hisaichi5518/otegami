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
        @message.reply "oK〜〜〜"
      end
    end
  end
end
