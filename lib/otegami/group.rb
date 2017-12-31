module Otegami
  class Group

    def initialize(members)
      @members = members
    end

    def include?(name)
      # TODO: members.include? を直接利用する
      members.include?(name)
    end

    def opponent(me)
      index = members.index(me)
      if index.nil?
        return nil
      end

      # 所属人数よりindexが多ければ一番最初の人
      opponentIndex = index + 1
      if members.size <= opponentIndex
        opponentIndex = 0
      end

      members[opponentIndex]
    end

    private
    def members
      @members ||= []
    end
  end
end
