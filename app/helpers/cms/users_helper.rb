module Cms::UsersHelper
  def update_site_users(site)
    check_box_tag "site",nil, @user.sites.include?(site), :onclick => "updateSiteUsers(#{site.id}, #{@user.id}, this.checked)"
  end
  def permission_check_box(permission)
    check_box_tag :module, permission, 
                  @user.has_permission?(permission), 
                  :onclick => "updateUserPermission(#{@user.id},(this.checked ? 1 : 0), this.value)"
  end
end
