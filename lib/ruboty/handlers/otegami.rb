require 'ruboty/actions/otegami'

module Ruboty
  module Handlers
    class Otegami < Base
      on(
        /.*/,
        description: 'お言葉を受け取ります',
        name: 'otegami',
        all: true
      )

      def otegami(message)
        Ruboty::Actions::Otegami.new(message).call
      end
    end
  end
end
