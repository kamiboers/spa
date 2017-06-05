require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  test "it should be invalid without a title or body" do
    task_without_title_or_body = Task.new

    refute(task_without_title_or_body.valid?)
  end

  test "it should be invalid without a title" do
    task = Task.new(body: "body")

    refute(task.valid?)
  end

  test "it should be invalid without a body" do
    task = Task.new(title: "title")

    refute(task.valid?)
  end

  test "it is valid with a title and body" do
    task_with_title_and_body = Task.new(title: "title", body: "body")

    assert(task_with_title_and_body.valid?)
  end

  test "it defaults to completion false" do
    new_task = Task.new(title: "title", body: "body")

    assert_equal(false, new_task.complete)
  end

  test "it toggles completion from false to true" do
    task = tasks(:one)
    task.complete = false
    task.toggle_completion

    assert(task.complete)
  end

  test "it toggles completion from true to false" do
    task = tasks(:one)
    task.complete = true
    task.toggle_completion

    refute(task.complete)
  end

end
