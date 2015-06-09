SUITS = %w[♦ ♣ ♠ ♥]
VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A]

class Card
 attr_reader :suit, :value

 def initialize(suit, value)
   @suit = suit
   @value = value
   @point = 0
 end

 def point
   if not ['J', 'Q', 'K', 'A'].include? @value
     @point = @value.to_i
   elsif not @value == 'A'
     @point = 10
   else
     @point = 'ace'
   end
 end
end
