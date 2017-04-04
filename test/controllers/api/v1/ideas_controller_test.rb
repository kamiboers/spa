require 'test_helper'

class Api::V1::IdeasControllerTest < ActionDispatch::IntegrationTest
  test "controller responds to json" do
    get '/api/v1/ideas', as: :json
    assert_response :success
  end

  test 'index returns an array of records' do
    get '/api/v1/ideas', as: :json

    assert_kind_of Array, json_response
  end
end
