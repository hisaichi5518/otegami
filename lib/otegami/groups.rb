module Otegami
  class Groups

    def initialize(raw_groups)
      raw_groups.each do |raw_group|
        groups.add(Group.new(raw_group))
      end
    end

    def find(name)
      groups.select { |group| group.include?(name) }.first
    end

    def push(group)
      groups.push(group)
    end

    private
    def groups
      @groups ||= []
    end
  end
end
