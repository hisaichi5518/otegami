require 'ruboty/actions/okotoba'

module Ruboty
  module Handlers
    class Okotoba < Base
      on(
        /bot hi/,
        description: 'お言葉を受け取ります',
        name: 'okotoba'
      )

      def okotoba(message)
        Ruboty::Actions::Okotoba.new(message).call
      end
    end
  end
end
