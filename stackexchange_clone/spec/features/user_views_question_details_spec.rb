require 'rails_helper'

feature 'user views question details', %Q{
  As a user
  I want to view a question's details
  So that I can effectively understand the question
  } do

# Acceptance Criteria

# - I must be able to get to this page from the questions index
# - I must see the question's title
# - I must see the question's description


  title =  "Is it possible to execute a load test, which uses a web test plugin by using MSTest command line?", 
  question_text =  "I have a web performance test, which uses web test plugin. Based on this web performance test, I created a load test. When I run the load test from the Visual Studio 2013, the load test runs correctly on all my remote agents. However when I run the same test by using MSTest command line, I get an error indicating that the PlugIn (C#) was not loaded. My question is whether it is possible to execute a load test (with plugin) by using the command line MSTest? If yes, then what I need to do to get rid of the error?"
  
  # let!(q1 = :question){Question.create(title: title, question: question_text)}  
    

  scenario "view all questions" do

    # title =  "Is it possible to execute a load test, which uses a web test plugin by using MSTest command line?", 
    # question_text =  "I have a web performance test, which uses web test plugin. Based on this web performance test, I created a load test. When I run the load test from the Visual Studio 2013, the load test runs correctly on all my remote agents. However when I run the same test by using MSTest command line, I get an error indicating that the PlugIn (C#) was not loaded. My question is whether it is possible to execute a load test (with plugin) by using the command line MSTest? If yes, then what I need to do to get rid of the error?"
  
    q1 = Question.create(title: title, question: question_text)

    visit '/questions'

    id ='#question_'+q1.id.to_s
    # save_and_open_page
    # click_link(id)
        page.find("#{id}").click
    # click_link(title)
    expect(page).to have_content(title[0][0,10])
    expect(page).to have_content(question_text[0][0,10])  
  end
end