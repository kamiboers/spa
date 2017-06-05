require 'test_helper'

class LoadingIdeasTest < ActionDispatch::IntegrationTest

  def setup
    super
    use_javascript
    visit root_path
  end

  def teardown
    super
    reset_driver
  end

  test "it creates a new idea upon form submission" do
    assert_difference 'Idea.count', 1 do
      page.fill_in "idea[title]", with: 'Special Idea'
      page.fill_in "idea[body]", with: 'World domination'
      page.click_button "submit"
      wait_for_ajax
    end
  end

  test "it does not create a new idea upon invalid form submission" do
    assert_difference 'Idea.count', 0 do
      page.fill_in "idea[title]", with: ''
      page.fill_in "idea[body]", with: ''
      page.click_button "submit"
      wait_for_ajax
    end
  end

  test "it shows an error saying that the title or body cannot be blank if missing" do
    page.click_button "submit"
    wait_for_ajax

    assert page.find('#new-idea-errors').has_content? "Title can't be blank"
    assert page.find('#new-idea-errors').has_content? "body can't be blank"
  end

  test "it removes the error on subsequent submissions" do
    page.click_button "submit"

    wait_for_ajax

    page.fill_in "idea[title]", with: "Special Idea"
    page.fill_in "idea[body]", with: "World domination"
    page.click_button "submit"

    refute page.find('#new-idea-errors').has_content? 'Title and/or body cannot be blank.'
  end
  
end