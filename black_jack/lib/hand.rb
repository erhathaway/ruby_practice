class Hand
  attr_accessor :hand, :score
  attr_reader :points
  def initialize
    @hand = []
    @score = 0
  end

  def score
    if @hand.length > 0
      @aces = 0
      @score = 0
      @hand.each do |card|
        unless card.point == 'ace'
          @score += card.point
        else
          @aces +=1
        end
      end
      #handle @aces----------------
      while @aces > 0
        if (@score + 11) <= 21 && @aces < 2
          @score += 11
        else
          @score += 1
        end
        @aces = @aces - 1
      end
      #--------------------------
    else
      "you ain't got a hand"
    end
    @score
  end
end
