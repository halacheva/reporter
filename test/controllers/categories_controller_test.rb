require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @category = categories(:travel)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should create category' do
    assert_difference('Category.count') do
      post :create, category: { name: 'Sport' }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test 'should show category' do
    get :show, id: @category
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @category
    assert_response :success
  end

  test 'should update category' do
    patch :update, id: @category, category: { name: @category.name }
    assert_redirected_to category_path(assigns(:category))
  end

  test 'should destroy category' do
    category_id = @category.id
    assert_difference('Category.count', -1) do
      delete :destroy, id: @category
    end

    assert_equal CategoriesReport.where(category_id: category_id).count, 0,
                 'reports associations to the deleted category should be destroyed'
    assert_redirected_to categories_path
  end
end
