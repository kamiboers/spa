require 'test_helper'

class IdeaTest < ActiveSupport::TestCase

  test "should have a quality that defaults to 0" do
    idea = Idea.new
    assert_equal('low', idea.quality)
  end
   
  test "it should be invalid without a title or body" do
    idea_without_title_or_body = Idea.new

    refute(idea_without_title_or_body.valid?)
  end

  test "it should be invalid without a title" do
    idea = Idea.new(body: "body")

    refute(idea.valid?)
  end

  test "it should be invalid without a body" do
    idea = Idea.new(title: "title")

    refute(idea.valid?)
  end

  test "it is valid with a title and body" do
    idea_with_title_and_body = Idea.new(title: "title", body: "body")

    assert(idea_with_title_and_body.valid?)
  end

  test "it is valid with a quality of low" do
    ideas(:one).quality = "low"

    assert(ideas(:one).valid?)
  end

  test "it is valid with a quality of medium" do
    ideas(:one).quality = "medium"

    assert(ideas(:one).valid?)
  end

  test "it is valid with a quality of high" do
    ideas(:one).quality = "high"

    assert(ideas(:one).valid?)
  end

  test "it is invalid with any other quality" do
    ideas(:one).quality = "invalid"

    refute(ideas(:one).valid?)
  end

end
