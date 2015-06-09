class Deck
  attr_reader :deck
  def initialize
    @deck = []
    SUITS.each do |suit|
      VALUES.each do |value|
        deck << Card.new(suit,value)
      end
    end
  end

  def deck_size
    @deck.length
  end

  def shuffle
    @deck = @deck.shuffle
  end

  def deal
    @deck.shift
  end
end
