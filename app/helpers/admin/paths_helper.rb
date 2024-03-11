module Admin::PathsHelper
  def clear_old
    content_for :title_btn, link_to("Clear", clear_admin_paths_path, method: :put, confirm: "Really?")
  end
end