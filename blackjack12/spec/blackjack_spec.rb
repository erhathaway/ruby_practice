require 'rspec'
require 'pry'
require_relative "../blackjack"

describe Card do
  describe "#initialize" do
    it 'has a suit and value' do
      test_card = Card.new("♥","Q")
      expect(test_card.suit).to eq("♥")
      expect(test_card.value).to eq("Q")
    end
    it 'has a suit and value' do
      test_card = Card.new("♣","6")
      expect(test_card.suit).to eq("♣")
      expect(test_card.value).to eq("6")
    end
  end

  describe "#point" do
    it 'has a point value' do
      test_card = Card.new("♣","6")
      test_card2 = Card.new("♥","Q")
      test_card3 = Card.new("♦","A")
      test_card4 = Card.new("♠","10")
      expect(test_card.point).to eq(6)
      expect(test_card2.point).to eq(10)
      expect(test_card3.point).to eq('ace')
      expect(test_card4.point).to eq(10)
    end
  end

end

describe Deck do
  describe "#initialize" do
    it 'has 52 card objects' do
      test_deck = Deck.new()
      expect(test_deck.deck_size).to eq(52)
      # expect(test_deck.).to eq(52)
    end
  end
  describe "#shuffle" do
    it 'shuffles the deck' do
      test_deck = Deck.new()
      test_cards = test_deck.deck
      expect(test_deck.deck).to eq(test_cards)
      test_deck.shuffle
      expect(test_deck.deck).not_to eq(test_cards)
    end
  end
  describe "#deal" do
    test_deck = Deck.new()
    it 'removes first card object from deck' do
      second_card = test_deck.deck[1]
      test_deck.deal
      expect(test_deck.deck[0]).to eq(second_card)
      expect(test_deck.deck_size).to eq(51)
    end
    it 'and returns card' do
      first_card = test_deck.deck[0]
      dealt_card = test_deck.deal
      expect(dealt_card).to eq(first_card)
    end
  end
end

describe Hand do
let(:test_deck) {Deck.new}
let(:test_hand) {Hand.new}

  describe "#initialize" do
    it 'creates an empty hand' do
      expect(test_hand.hand.length).to eq(0)
    end
  end

  context "dealt first card" do
    it 'recieves a card from the deck' do
      test_hand.hand << test_deck.deal
      expect(test_hand.hand.length).to eq(1)
      expect(test_deck.deck_size).to eq(51)
    end
    it 'and has a score' do
      test_hand.hand << test_deck.deal
      expect(test_hand.score).to be_between(1, 11).inclusive
    end
  end

  context "dealt second card" do
    it 'recieves a card from the deck' do
      test_hand.hand << test_deck.deal
      test_hand.hand << test_deck.deal
      expect(test_hand.hand.length).to eq(2)
      expect(test_deck.deck_size).to eq(50)
    end
    it 'and has a score' do
      test_hand.hand << test_deck.deal
      test_hand.hand << test_deck.deal
      expect(test_hand.score).to be_between(2, 22).inclusive
    end
  end

  describe "#score" do
    it 'tallys score of hand' do

      #put cards into hand

    end
  end


end
