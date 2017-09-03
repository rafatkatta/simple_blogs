ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end
    
    columns do
      column do
        panel "Categories" do
          ol do
            Category.all.map do |category|
              li (category.name)
            end
          end
        end
      end
      column do
        panel "Last update Blogs" do
          ol do
            Blog.order(:updated_at).limit(10).map do |blog|
              li (blog.name)
            end
          end
        end
      end
    end
  end # content
end
