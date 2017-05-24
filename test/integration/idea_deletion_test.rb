require 'test_helper'

class DeletingIdeasTest < ActionDispatch::IntegrationTest

  def setup
    create_idea
    use_javascript
    visit root_path
  end

  def teardown
    reset_driver
  end

  test "delete button removes an idea from the page" do
    assert_difference "page.find_all('.idea').count", -1 do
      page.find_all(".idea-delete").first.click

      wait_for_ajax
    end
  end

  private

  def create_idea
    Idea.create(title: "Gone Soon", body: "Bye")
  end

end