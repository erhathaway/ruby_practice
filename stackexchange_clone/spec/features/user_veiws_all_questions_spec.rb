require 'rails_helper'

feature 'user views all questions', %Q{
	As a user
	I want to view recently posted questions
	So that I can help others
} do

#   Acceptance Criteria

# - I must see the title of each question
# - I must see questions listed in order, most recently posted first

    title =  "Is it possible to execute a load test, which uses a web test plugin by using MSTest command line?", 
    question_text =  "I have a web performance test, which uses web test plugin. Based on this web performance test, I created a load test. When I run the load test from the Visual Studio 2013, the load test runs correctly on all my remote agents. However when I run the same test by using MSTest command line, I get an error indicating that the PlugIn (C#) was not loaded. My question is whether it is possible to execute a load test (with plugin) by using the command line MSTest? If yes, then what I need to do to get rid of the error?"
  
  let!(:question){Question.create(title: title, question: question_text)}  
    

  scenario "view all questions" do
    visit '/questions'
    
    expect(page).to have_content(title[0][0,10])
    expect(page).to have_content(question_text[0][0,10])  

  end
end