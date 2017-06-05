require 'test_helper'

class DeletingTasksTest < ActionDispatch::IntegrationTest

  def setup
    @task = create_task
    use_javascript
    visit root_path
  end

  def teardown
    reset_driver
  end

  test "delete button removes an task from the page" do
    assert_difference "page.find_all('.task').count", -1 do
      page.find_all(".delete-button").first.click
      wait_for_ajax
      wait_for_delay
    end
  end

  private

  def create_task
    Task.create(title: "Gone Soon", body: "Bye")
  end

end