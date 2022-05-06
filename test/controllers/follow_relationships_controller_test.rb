require "test_helper"

class FollowRelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get follow_relationships_index_url
    assert_response :success
  end
end
