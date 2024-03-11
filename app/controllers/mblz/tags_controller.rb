class Mblz::TagsController < MblzController
  def update
    contact = current_site.contacts.find(params[:contact_id])
    tag     = current_site.tags.find(params[:id])
    if contact.tags.include?(tag)
       contact.tags.delete tag
    else
      contact.tags << tag
    end

    flash[:notice] = "Tag updated"
    redirect_to mblz_contact_path(contact)
  end

  def show
    @tag      = current_site.tags.find(params[:id])
    @contacts = @tag.contacts
    #render 'mblz/contacts/_contacts'
  end
end