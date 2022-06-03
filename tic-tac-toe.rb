class Player
  def initialize(mark)
    @mark = mark
  end
end

class Board
  def initialize
    self.board = Array.new(3, Array.new(3, nil))
  end
end
