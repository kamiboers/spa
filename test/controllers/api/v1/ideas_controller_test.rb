require 'test_helper'

class Api::V1::IdeasControllerTest < ActionDispatch::IntegrationTest
  test "controller responds to json" do
    get api_v1_ideas_path, as: :json
    assert_response :success
  end

  test 'index returns an array of records' do
    get api_v1_ideas_path, as: :json
    assert_kind_of Array, json_response
  end

  test '#index returns the correct number of ideas' do
    get api_v1_ideas_path, as: :json
    assert_equal Idea.count, json_response.count
  end

  test '#index contains ideas with the correct properties' do
    get api_v1_ideas_path, as: :json
    json_response.each do |idea|
      assert idea["title"]
      assert idea["body"]
      assert idea["quality"]
    end
  end

  test "show action responds to json" do
    id = ideas(:one).id
    get api_v1_idea_path(id), as: :json
    assert_response :success
  end

  test "#show responds with a particular idea" do
    id = ideas(:one).id
    get api_v1_idea_path(id), as: :json
    assert_equal id, json_response["id"]
  end

  test "#create adds an additional idea to to the database" do
    assert_difference 'Idea.count', 1 do
      idea = { title: "New Idea", body: "Something" }
      post api_v1_ideas_path, params: { idea: idea, format: :json }
    end
  end

  test "#create returns the new idea" do
    idea = { title: "New Idea", body: "Something" }
    post api_v1_ideas_path, params: { idea: idea, format: :json }
    assert_equal idea[:title], json_response["title"]
    assert_equal idea[:body], json_response["body"]
    assert_equal "low", json_response["quality"]
  end

  test "#create rejects ideas without a title" do
    idea = { body: 'Something' }
    # number_of_ideas = Idea.all.count
    post api_v1_ideas_path, params: { idea: idea, format: :json }
    assert_response 422
    assert_includes json_response["errors"]["title"], "can't be blank"
  end

  test "#create rejects ideas without a body" do
    idea = { title: 'New Idea' }
    # number_of_ideas = Idea.all.count 
    post api_v1_ideas_path, params: { idea: idea, format: :json }

    assert_response 422
    assert_includes json_response["errors"]["body"], "can't be blank"
  end



end