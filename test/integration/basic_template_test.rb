require 'test_helper'

class BasicTemplateTest < ActionDispatch::IntegrationTest
  
  test "it loads a page at the application root" do
    visit root_path
    assert page.status_code == 200 || page.status_code == 304
  end

  test "it has an <h1> tag with the content taskbox" do
    visit root_path
    assert page.find("h1").has_content? "taskbox"
  end

  test "it has an tasks container on the page" do
    visit root_path
    assert page.has_css? ".tasks-container"
  end

  test "it has a form for creating new tasks" do
    visit root_path
    assert page.has_css? "form.new-task-form"
  end

  test "form has an text input for a new task title" do
    visit root_path
    assert page.has_css? "form.new-task-form input[type='text']#new-task-title"
  end

  test "form has an text input for a new task body" do
    visit root_path
    assert page.has_css? "form.new-task-form textarea#new-task-body"
  end

  test "form has an input button" do
    visit root_path
    assert page.has_css? "form.new-task-form button#new-task-submit"
  end

  test "switch to javascript driver does not error" do
      use_javascript
      visit root_path
      # Do some stuff
  end


end