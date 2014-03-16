ActiveAdmin.register Report do

  permit_params :title, :description, :body, :location, :active, :user, category_ids: []
  actions :index, :show, :edit, :update, :destroy

  controller do
    def scoped_collection
      resource_class.includes(:categories)
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :body
    column :location
    column :active
    column :categories_count do |report|
      report.categories.size
    end
    actions
  end

  show do
    attributes_table do
      row :title
      row :user
      row :description
      row :body
      row :location
      row :active do |report|
        status_tag(report.active ? "YES" : "NO")
      end
      row :categories_count do |report|
        report.categories.size
      end
      table_for report.categories, :class => 'index_table' do
        column "Categories" do |category|
          link_to category.name, category
        end
      end
    end
  end

  filter :title
  filter :description
  filter :location
  filter :categories, as: :check_boxes

  form do |f|
    f.inputs "Report Details" do
      f.input :title
      f.input :user, member_label: :email, include_blank: false
      f.input :description
      f.input :body
      f.input :location
      f.input :active
      f.input :categories, as: :check_boxes
    end
    f.actions
  end

end
