class BulletinsControllerTest < ActionController::TestCase
  setup do
    @bulletin_one = bulletins(:bulletin_one)
    @bulletin_two = bulletins(:bulletin_two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bulletins)
    assert_select 'ul li', count: 2
  end

  test "should show bulletin" do
    get :show, params: { id: @bulletin_one }
    assert_response :success
    assert_not_nil assigns(:bulletin)
    assert_select 'h1', @bulletin_one.title
    assert_select 'p', @bulletin_one.description
  end
end
