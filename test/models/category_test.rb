require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test 'should not allow category without name' do
    category = Category.new

    assert category.invalid?
    assert category.errors[:name].any?, 'category without name should not be valid'
  end

  test 'should allow category with name length >= 2 chars' do
    category = Category.new name: 'n'

    assert category.invalid?
    assert category.errors[:name].any?, 'category with name length < 2 chars should not be valid'

    category.name = 'name'
    assert category.valid?, 'category with name length >= 2 chars should be valid'
  end

  test 'should allow category with unique name' do
    category = Category.new name: categories(:politics).name

    assert category.invalid?
    assert category.errors[:name].any?, 'category without unique name should not be valid'
  end
end
