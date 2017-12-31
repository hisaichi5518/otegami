module Ruboty
  module Actions
    class NotifyResult < Base
      def initialize(message)
        @message = message
      end

      def call
        groups.each do |members|
          group = ::Otegami::Group.new(members)
          result = ""
          members.each do |member|
            result += <<-"EOF"
@#{member} →@#{group.opponent(member)}
```
#{messages[member]}
```
---
            EOF
          end

          res = client.create_issue("hisaichi5518/otegami", "お手紙 #{Time.now}", "#{result}")
          @message.reply "みなさん、お手紙が届きましたよ！ #{res[:html_url]}"
        end
      end

      private
      def client
        @client ||= Octokit::Client.new(access_token: ENV['GHE_TOKEN'])
      end

      def groups
        data[:groups] ||= []
      end

      def saveMessage(name, body)
        messages = data[:messages] ||= {}
        messages[name] = body
      end

      def messages
        data[:messages] ||= {}
      end

      def data
        @message.robot.brain.data[:otegami] ||= {}
      end
    end
  end
end
