require 'test_helper'

class BasicTemplateTest < ActionDispatch::IntegrationTest
  
  test "it loads a page at the application root" do
    visit root_path
    assert page.status_code == 200 || page.status_code == 304
  end

  test "it has an <h1> tag with the content ideabox" do
    visit root_path
    assert page.find("h1").has_content? "ideabox"
  end

  test "it has an ideas container on the page" do
    visit root_path
    assert page.has_css? ".ideas-container"
  end

  test "it has a form for creating new ideas" do
    visit root_path
    assert page.has_css? "form.new-idea-form"
  end

  test "form has an text input for a new idea title" do
    visit root_path
    assert page.has_css? "form.new-idea-form input[type='text']#new-idea-title"
  end

  test "form has an text input for a new idea body" do
    visit root_path
    assert page.has_css? "form.new-idea-form textarea#new-idea-body"
  end

  test "form has an input button" do
    visit root_path
    assert page.has_css? "form.new-idea-form button#new-idea-submit"
  end

  test "switch to javascript driver does not error" do
      use_javascript
      visit root_path
      # Do some stuff
  end


end