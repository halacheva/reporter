require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  setup do
    @report = reports(:hawaii)
    @category_ids = Category.pluck(:id)
    @categories_count = Category.count
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:reports)
  end

  test 'should get new' do
    get :new
    assert_response :success

    assert_select 'div.categories' do
      assert_select 'input[type=\'checkbox\']', @categories_count,
        'should show all categories'
    end
  end

  test 'should create report' do
    assert_difference('Report.count') do
      post :create, report: { body: @report.body,
                              description: @report.description,
                              location: @report.location,
                              title: @report.title,
                              category_ids: @category_ids }
    end

    assert_equal Report.last.categories.size, @category_ids.size,
      'report should have been associated with all requested categories'
    assert_redirected_to report_path(assigns(:report))
  end

  test 'should show report' do
    get :show, id: @report
    assert_response :success

    assert_select 'p.categories' do
      assert_select 'span', @report.categories.size, 'report should show the associated categories'
    end
  end

  test 'should get edit' do
    get :edit, id: @report
    assert_response :success

    assert_select 'div.categories' do
      assert_select 'input[type=\'checkbox\']', @categories_count,
        'should show all categories'
    end

    @report.categories do |category|
      assert_select "category_#{category.id}[checked]", true, 'report category should be checked'
    end
  end

  test 'should update report' do
    patch :update, id: @report, report: { body: @report.body,
                                          description: @report.description,
                                          location: @report.location,
                                          title: @report.title,
                                          category_ids: @category_ids }

    assert_equal @report.categories.size, @category_ids.size,
      'report should have been associated with all requested categories'
    assert_redirected_to report_path(assigns(:report))
  end

  test 'should destroy report' do
    report_id = @report.id
    assert_difference('Report.count', -1) do
      delete :destroy, id: @report
    end

    assert_equal CategoriesReport.where(report_id: report_id).count, 0,
                 'categories associations to the deleted report should be destroyed'
    assert_redirected_to reports_path
  end
end
