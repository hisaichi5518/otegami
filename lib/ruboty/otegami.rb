require 'otegami/config'
require 'otegami/group'
require 'otegami/groups'

require 'ruboty/otegami/version'
require 'ruboty/handlers/otegami'

Slack.configure do |config|
  config.token = ENV["SLACK_TOKEN"]
end
