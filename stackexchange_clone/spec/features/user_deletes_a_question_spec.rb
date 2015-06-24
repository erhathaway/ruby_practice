require 'rails_helper'

feature "user deletes a question", %Q{
  As a user
  I want to delete a question
  So that I can delete duplicate questions
  } do

# Acceptance Criteria

# - I must be able delete a question from the question edit page
# - I must be able delete a question from the question details page
# - All answers associated with the question must also be deleted

  title =  "Is it possible to execute a load test, which uses a web test plugin by using MSTest command line?", 
  question_text =  "I have a web performance test, which uses web test plugin. Based on this web performance test, I created a load test. When I run the load test from the Visual Studio 2013, the load test runs correctly on all my remote agents. However when I run the same test by using MSTest command line, I get an error indicating that the PlugIn (C#) was not loaded. My question is whether it is possible to execute a load test (with plugin) by using the command line MSTest? If yes, then what I need to do to get rid of the error?"

  let!(:question){Question.create(title: title, question: question_text)}  
    
	question_answer1 = "hello world blah blah blah blah aklsjdf;lakjdflkajds;lkfaj;sdklfj"
	question_answer2 = "too short"

	scenario "delete a question" do
		question
    visit '/questions'
    page.first('.question > a').click
    expect(page).to have_content(question_text)
    click_link('Delete')
    expect(page).to have_no_content(question_text)
  end

end