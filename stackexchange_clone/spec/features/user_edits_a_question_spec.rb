require 'rails_helper'

feature "user edits a question", %Q{
  As a user
  I want to edit a question
  So that I can correct any mistakes or add updates
  } do

# Acceptance Criteria

# - I must provide valid information
# - I must be presented with errors if I fill out the form incorrectly
# - I must be able to get to the edit page from the question details page

  title =  "Is it possible to execute a load test, which uses a web test plugin by using MSTest command line?", 
  question_text =  "I have a web performance test, which uses web test plugin. Based on this web performance test, I created a load test. When I run the load test from the Visual Studio 2013, the load test runs correctly on all my remote agents. However when I run the same test by using MSTest command line, I get an error indicating that the PlugIn (C#) was not loaded. My question is whether it is possible to execute a load test (with plugin) by using the command line MSTest? If yes, then what I need to do to get rid of the error?"

  let!(:question){Question.create(title: title, question: question_text)}  
    
	question_answer1 = "hello world blah blah blah blah aklsjdf;lakjdflkajds;lkfaj;sdklfj"
	question_answer2 = "too short"

	scenario "edit a question" do
		question
    visit '/questions'
    page.first('.question > a').click
    click_link('Edit')
    # save_and_open_page
    fill_in 'Title', :with => " "
    fill_in 'Question', :with => " "
    save_and_open_page
    click_button 'Update Question'

    expect(page).to have_content(question_answer1)
  end

end






