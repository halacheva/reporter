ActiveAdmin.register Report do

  permit_params :title, :description, :body, :location, :active, :user,
                images_attributes: [:id, :label, :file, :_destroy], category_ids: []
  actions :index, :show, :edit, :update, :destroy

  controller do
    def scoped_collection
      resource_class.includes(:categories, :images)
    end
  end

  index do
    selectable_column
    id_column
    column :title
    column :image do |report|
      if report.images.blank?
        'N / A'
      else
        image_tag(report.images.first.file.url(:thumb))
      end
    end
    column :user
    column :description
    column :body
    column :location
    column :active
    column :categories_count do |report|
      report.categories.size
    end
    column :images_count do |report|
      report.images.size
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
        status_tag(report.active ? 'YES' : 'NO')
      end
      row :categories_count do |report|
        report.categories.size
      end
      table_for report.categories, class: 'index_table' do
        column 'Categories' do |category|
          link_to category.name, category
        end
      end
      row :images_count do |report|
        report.images.size
      end
      table_for report.images, class: 'index_table' do
        column 'Images' do |image|
          (content_tag(:span, image.label).to_s + image_tag(image.file.url(:medium)).to_s).html_safe
        end
      end
    end
  end

  filter :title
  filter :description
  filter :location
  filter :categories, as: :check_boxes

  form do |f|
    f.inputs 'Report Details' do
      f.input :title
      f.input :user, member_label: :email, include_blank: false
      f.input :description
      f.input :body
      f.input :location
      f.input :active
      f.input :categories, as: :check_boxes
      f.has_many :images, allow_destroy: true, heading: 'Images', new_record: true do |images_form|
        images_form.input :label
        # Paperclip new version is not working properly with formastic
        # soooooo you have to add required: false to fix this issue!!!!!!!!
        images_form.input :file,
                          required: false,
                          as: :file,
                          hint: images_form.template.image_tag(images_form.object.file.url(:thumb))
      end
    end
    f.actions
  end

end
