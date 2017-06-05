require 'test_helper'

class LoadingTasksTest < ActionDispatch::IntegrationTest

  def setup
    super
    use_javascript
    visit root_path
  end

  def teardown
    super
    reset_driver
  end

  test "it creates a new task upon form submission" do
    assert_difference 'Task.count', 1 do
      page.fill_in "task[title]", with: 'Special Task'
      page.fill_in "task[body]", with: 'World domination'
      page.click_button "submit"
      wait_for_ajax
    end
  end

  test "it does not create a new task upon invalid form submission" do
    assert_difference 'Task.count', 0 do
      page.fill_in "task[title]", with: ''
      page.fill_in "task[body]", with: ''
      page.click_button "submit"
      wait_for_ajax
    end
  end

  test "it shows an error saying that the title or body cannot be blank if missing" do
    page.click_button "submit"
    wait_for_ajax

    assert page.find('#new-task-errors').has_content? "Title can't be blank"
    assert page.find('#new-task-errors').has_content? "body can't be blank"
  end

  test "it removes the error on subsequent submissions" do
    page.click_button "submit"
    wait_for_ajax

    page.fill_in "task[title]", with: "Special Task"
    page.fill_in "task[body]", with: "World domination"
    page.click_button "submit"

    refute page.find('#new-task-errors').has_content? 'Title and/or body cannot be blank.'
  end
  
end