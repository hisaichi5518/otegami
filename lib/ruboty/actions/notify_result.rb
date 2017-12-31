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

          config = ::Otegami::Config.new
          res = client.create_issue(config.repo, "お手紙 #{Time.now}", result)
          @message.reply "#{config.result_message} #{res[:html_url]}"
        end
      end

      private
      def client
        @client ||= Octokit::Client.new(access_token: ENV['GHE_TOKEN'])
      end

      def groups
        data[:groups] ||= []
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
