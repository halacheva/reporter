ActiveAdmin.register User do

  permit_params :email, :password, :password_confirmation, :admin
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
      row :admin do |user|
        status_tag(user.admin ? "YES" : "NO")
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
      table_for user.reports, :class => 'index_table' do
        column "Report" do |report|
          link_to report.title, report
        end
      end
    end
  end

  filter :email
  filter :admin
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at, label: "Registration Date"

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :admin
    end
    f.actions
  end

end
