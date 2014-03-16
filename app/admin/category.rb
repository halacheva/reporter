ActiveAdmin.register Category do

  permit_params :name

  controller do
    def scoped_collection
      resource_class.includes(:reports)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :reports_count do |category|
      category.reports.size
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :reports_count do |category|
        category.reports.size
      end
      table_for category.reports, :class => 'index_table' do
        column "Reports" do |report|
          link_to report.title, report
        end
      end
    end
  end

  filter :name
  filter :reports, as: :check_boxes

  form do |f|
    f.inputs "Category Details" do
      f.input :name
    end
    f.actions
  end

end
