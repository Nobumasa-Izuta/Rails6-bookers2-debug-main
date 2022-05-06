require "test_helper"

class FollowerRelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get follower_relationships_index_url
    assert_response :success
  end
end
