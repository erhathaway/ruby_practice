#!/usr/bin/env ruby
require 'pry'
require_relative 'card'
require_relative 'deck'
require_relative 'hand'

puts "Welcome to blackjack!\n\n"

#create objects
@dealer = Hand.new
@player = Hand.new
@players = {'Player' => @player, 'Dealer' => @dealer}
@deck = Deck.new

#deal cards to @players one at a time
def deal
  count = 0
  @deck.shuffle
  while count < (@players.length)*2
    @players.each do |player_name,hand|
      card = @deck.deal
      hand.hand << card
      card_dealt(player_name, card.suit + "" + card.value)
      player_score(player_name)
      count +=1
    end
  end
end

def card_dealt(player_name, card)
  puts "#{player_name} was dealt: #{card}\n"
end

def player_score(player_name)
  player_score = @players[player_name].score
  puts "#{player_name} score: #{player_score}\n\n"
  player_score
end

def eval_player_input
  puts "\e[33mHit or stand (H/S):\e[0m"
  player_choice = gets.chomp.to_s.upcase
  while player_choice != 'H' && player_choice != 'S'
    puts "Please be more clear...Enter 'H' or 'S'"
    player_choice = gets.chomp.to_s.upcase
  end
  player_choice
end


def get_player_choice
    player_choice = eval_player_input
    while player_choice == 'H'
      card = @deck.deal
      @player.hand << card
      card_dealt("Player",card.suit + "" + card.value)
      score = player_score("Player")
      if score < 21
        player_choice = eval_player_input
      else
        return score
      end
    end
    score = player_score("Player")
end

def get_dealer_choice
  # if @dealer.score < 17
    card = @deck.deal
    @dealer.hand << card
    card_dealt("Dealer",card.suit + "" + card.value)
    player_score("Dealer")
  # else
  #   puts "Dealer stays at #{@dealer.score}\n\n"
  # end
  @dealer.score
end

# determine if player has gone over 21, if not, go to dealer
def settle_score(player_score)
  if player_score > 21
    puts "\e[4;31mBust! Game over...\e[0m"
  else
    dealer_score = get_dealer_choice

    while dealer_score < 17 or (player_score > dealer_score && player_score <= 21)
      dealer_score = get_dealer_choice
    end

    if dealer_score > player_score && dealer_score <= 21
      puts "Dealer wins!"
    elsif dealer_score == player_score
      puts "Dealer wins!"
    elsif dealer_score > 21
      puts "\e[4;32mBust! You win!\e[0m"
    else
      puts "\e[4;32mYou win!\e[0m"
    end

  end
end

#run program
deal
player_score = get_player_choice
settle_score(player_score)
