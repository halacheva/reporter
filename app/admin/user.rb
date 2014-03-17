ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation, :admin, :avatar, :delete_avatar
  actions :index, :edit, :update, :show, :destroy

  controller do
    def scoped_collection
      resource_class.includes(:reports)
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :admin
    column :avatar do |user|
      image_tag(user.avatar.url(:thumb))
    end
    column :current_sign_in_at
    column :current_sign_in_ip
    column :registration_date, :created_at
    column :reports_count do |user|
      user.reports.size
    end
    actions
  end

  show do
    attributes_table do
      row :email
      row :avatar do |user|
        image_tag(user.avatar.url(:profile))
      end
      row :admin do |user|
        status_tag(user.admin ? 'YES' : 'NO')
      end
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :registration_date do |user|
        user.created_at
      end
      row :reports_count do |user|
        user.reports.size
      end
      table_for user.reports, class: 'index_table' do
        column 'Report' do |report|
          link_to report.title, report
        end
      end
    end
  end

  filter :email
  filter :admin
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at, label: 'Registration Date'

  form do |f|
    f.inputs 'User Details' do
      f.input :email
      f.input :admin
      # Paperclip new version is not working properly with formastic
      # soooooo you have to add required: false to fix this issue!!!!!!!!
      f.input :avatar,
              required: false,
              as: :file,
              hint: f.template.image_tag(f.object.avatar.url(:thumb))
      f.input :delete_avatar, as: :boolean
    end
    f.actions
  end
end
