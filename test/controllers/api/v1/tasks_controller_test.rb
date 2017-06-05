require 'test_helper'

class Api::V1::TasksControllerTest < ActionDispatch::IntegrationTest

  test "controller responds to json" do
    get api_v1_tasks_path, as: :json
    assert_response :success
  end

  test 'index returns an array of records' do
    get api_v1_tasks_path, as: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of tasks' do
    get api_v1_tasks_path, as: :json
    assert_equal Task.count, json_response.count
  end

  test '#index contains tasks with the correct properties' do
    get api_v1_tasks_path, as: :json
    json_response.each do |task|
      assert task["title"]
      assert task["body"]
    end
  end

  test "show action responds to json" do
    id = tasks(:one).id
    get api_v1_task_path(id), as: :json
    assert_response :success
  end

  test "#show responds with a particular task" do
    id = tasks(:one).id
    get api_v1_task_path(id), as: :json
    assert_equal id, json_response["id"]
  end

  test "#create adds an additional task to to the database" do
    assert_difference 'Task.count', 1 do
      task = { title: "New Task", body: "Something" }
      post api_v1_tasks_path, params: { task: task, format: :json }
    end
  end

  test "#create returns the new task" do
    task = { title: "New Task", body: "Something" }
    post api_v1_tasks_path, params: { task: task, format: :json }
    assert_equal task[:title], json_response["title"]
    assert_equal task[:body], json_response["body"]
  end

  test "#create rejects tasks without a title" do
    task = { body: 'Something' }
    post api_v1_tasks_path, params: { task: task, format: :json }
    assert_response 422
    assert_includes json_response["errors"]["title"], "can't be blank"
  end

  test "#create rejects tasks without a body" do
    task = { title: 'New Task' }
    post api_v1_tasks_path, params: { task: task, format: :json }

    assert_response 422
    assert_includes json_response["errors"]["body"], "can't be blank"
  end

  test "#update an task through the API" do
    updated_content = { title: "Updated Task" }
    id = tasks(:one).id
    put api_v1_task_path(id), as: :json, params: { task: updated_content }
    tasks(:one).reload

    assert_equal "Updated Task", tasks(:one).title
  end

  test "#update the completion of an task" do
    id = tasks(:one).id
    put api_v1_task_toggle_path(id), as: :json
    tasks(:one).reload

    assert_equal true, tasks(:one).complete
  end

  test "#destroy removes an task" do
    task = tasks(:one)
    assert_difference('Task.count', -1) do
      delete api_v1_task_url(task)
    end
  end

end
