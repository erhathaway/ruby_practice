require 'pry'

def get_computer_choice()
  input = rand(3)
  case input
    when 0
      choice = 'rock'
    when 1
      choice = 'paper'
    when 2
      choice = 'scissors'
  end
  choice
end

def battle(player,computer)
  case [player,computer]
    when ['rock', 'scissors']
       return 'player'
    when ['rock', 'paper']
       return 'computer'
    when ['rock', 'rock']
       return 'tie'
    when ['paper', 'scissors']
      return 'computer'
    when ['paper', 'paper']
      return 'tie'
    when ['paper', 'rock']
      return 'player'
    when ['scissors', 'scissors']
      return 'tie'
    when ['scissors', 'paper']
      return 'player'
    when ['scissors', 'rock']
      return 'computer'
  end
end

def play(player_choice, player_score, computer_score)
  # binding.pry
  computer_choice = get_computer_choice
  outcome = battle(player_choice, computer_choice)
  status = nil
  case outcome
  when 'tie'
    message = 'Tie'
  when 'player'
    player_score+=1
    message = "Player won round"
  when 'computer'
    computer_score+=1
    message = "Computer wins round"
  end
  if player_score > 2
    status = "Player Won"
    message = "Player Won Game"
  elsif computer_score > 2
    status = "Computer Won"
    message = "Computer Won Game"
  end
  message = [message, player_choice, computer_choice]
  [status, message, player_score, computer_score]

end
