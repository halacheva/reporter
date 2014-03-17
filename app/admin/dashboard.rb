ActiveAdmin.register_page 'Dashboard' do

  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: 'Dashboard' do
    columns do
      column do
        panel 'Statistics' do
          ul do
            li "<b>Total reports: #{Report.count}</b>".html_safe
            li "<b>Total categories: #{Category.count}</b>".html_safe
            li "<b>Total users: #{User.count}</b>".html_safe
          end
        end
      end

      column do
        panel 'Recent Reports' do
          ul do
            Report.last(5).each do |report|
              li link_to(report.title, report)
            end
          end
        end
      end
    end
  end
end
