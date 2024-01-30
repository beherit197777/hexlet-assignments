# frozen_string_literal: true

class BulletinsControllerTest < ActionController::TestCase
  setup do
    @bulletin_one = bulletins(:bulletin_one)
    @bulletin_two = bulletins(:bulletin_two)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:bulletins)
  end

  test 'should show bulletin' do
    get :show, params: { id: @bulletin_one }
    assert_response :success
    assert_not_nil assigns(:bulletin)
  end
end
