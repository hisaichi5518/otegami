module Ruboty
  module Actions
    class NotifyResult < Base
      def initialize(message)
        @message = message
      end

      def call
        groups.each do |members|
          group = ::Otegami::Group.new(members)
          members.each do |member|
            # TODO: Github に投稿する
            p group.opponent(member) + "さんへ"
            p messages[member]
            p member + "より"
          end

          @message.reply "こんな感じでした！"
        end
      end

      private
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
