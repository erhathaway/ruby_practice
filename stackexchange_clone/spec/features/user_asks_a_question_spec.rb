require 'rails_helper'

feature 'user asks a question', %Q{
  As a user
  I want to post a question
  So that I can receive help from others
  } do

# Acceptance Criteria

# - I must provide a title that is at least 40 characters long
# - I must provide a description that is at least 150 characters long
# - I must be presented with errors if I fill out the form incorrectly

  question_title1 = "hello new world. where am i? nokogiri? nonsense?"
  question_text1 =  "Moments its musical age explain. But extremity sex now education concluded earnestly her continual. Oh furniture acuteness suspected continual ye something frankness. Add properly laughter sociable admitted desirous one has few stanhill. Opinion regular in perhaps another enjoyed no engaged he at. It conveying he continual ye suspected as necessary. Separate met packages shy for kindness. 
      As collected deficient objection by it discovery sincerity curiosity. Quiet decay who round three world whole has mrs man. Built the china there tried jokes which gay why. Assure in adieus wicket it is. But spoke round point and one joy. Offending her moonlight men sweetness see unwilling. Often of it tears whole oh balls share an. 
      Assure polite his really and others figure though. Day age advantages end sufficient eat expression travelling. Of on am father by agreed supply rather either. Own handsome delicate its property mistress her end appetite. Mean are sons too sold nor said. Son share three men power boy you. Now merits wonder effect garret own. "

  scenario "ask a question" do
    visit '/questions/new'
    fill_in 'Title', with: question_title1
    fill_in 'Question', with: question_text1

    click_button 'Ask Question'

    visit '/'

    expect(page).to have_content('Moments its musical age explain. But extremity sex now education')
  end

  scenario "ask a question incorrectly" do
    visit '/questions/new'
    fill_in 'Title', with: 'Hello World'
    fill_in 'Question', with: question_text1

    click_button 'Ask Question'

    expect(page).to have_content('Please make the question title longer than 40 characters')
  end
end

