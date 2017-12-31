require 'yaml'

module Otegami
  class Config

    def initialize
      @yaml = ::YAML.load_file(".otegami.yml")
    end

    def members
      @yaml["members"] ||= []
    end

    def repo
      @yaml["repo"] ||= "hisaichi5518/otegami"
    end

    def result_message
      @yaml["result_message"] ||= ""
    end
  end
end
