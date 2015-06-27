require 'rails_helper'

feature "user answers a question", %Q{
	As a user
	I want to answer another user's question
	So that I can help them solve their problem 
	} do

# Acceptance Criteria

# - I must be on the question detail page
# - I must provide a description that is at least 50 characters long
# - I must be presented with errors if I fill out the form incorrectly

  title =  "Is it possible to execute a load test, which uses a web test plugin by using MSTest command line?", 
  question_text =  "I have a web performance test, which uses web test plugin. Based on this web performance test, I created a load test. When I run the load test from the Visual Studio 2013, the load test runs correctly on all my remote agents. However when I run the same test by using MSTest command line, I get an error indicating that the PlugIn (C#) was not loaded. My question is whether it is possible to execute a load test (with plugin) by using the command line MSTest? If yes, then what I need to do to get rid of the error?"

  let!(:question){Question.create(title: title, question: question_text)}  
    
	question_answer1 = "hello world blah blah blah blah aklsjdf;lakjdflkajds;lkfaj;sdklfj"
	question_answer2 = "too short"

	scenario "answer a question" do
		question
    visit '/questions'
    page.first('.question_content > a').click
    page.find("#answer").click

    fill_in 'Answer', with: question_answer1

    click_button 'Submit Answer'

    expect(page).to have_content(question_answer1)
  end

  scenario "answers a question incorrectly" do
		question
    visit '/questions'
    page.first('.question_content > a').click
    page.find("#answer").click

    fill_in 'Answer', with: question_answer2

    click_button 'Submit Answer'

    expect(page).to have_content('Please make the question title longer than 50 characters')
  end
end






