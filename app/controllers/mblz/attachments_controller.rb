class Mblz::AttachmentsController < MblzController
  
  before_filter :set_invoice
  def create

    names  = params[:names]
    titles = params[:titles]
    params[:files].each_with_index do |file,i|
      att = @invoice.attachments.create!(before_or_after: params[:ba], image: file)
      new_file_name = names[i]
      (att.image.styles.keys+[:original]).each do |style|
          path = att.image.path(style)
          FileUtils.move(path, File.join(File.dirname(path), new_file_name))
      end      
      att.update_attributes(image_file_name: new_file_name, title: titles[i])
    end
    
    render nothing: true
  end

  def destroy
  	@invoice.attachments.find(params[:id]).destroy
  	flash[:notice] = "Deleted"
  	redirect_to mblz_invoice_path(@invoice)
  end

  def new
    @s_before = params[:ba] == '0' ? 'Before' : 'After'
  end

  def edit
    @attachment = @invoice.attachments.find(params[:id])
  end

  def update
    @attachment = @invoice.attachments.find(params[:id])
    @attachment.update_attributes(att_params)
    redirect_to mblz_invoice_path(@invoice)
  end

  def move
    @attachment = @invoice.attachments.find(params[:id])
    if params[:up]
      @attachment.move_higher
    else
      @attachment.move_lower
    end

    redirect_to edit_mblz_invoice_attachment_path(@invoice, @attachment)
  end

  private

  def attachment_params
    params.require(:attachment).permit!
  end

  def set_invoice
  	@invoice = current_site.invoices.find(params[:invoice_id])
  end

  def att_params
    params.require(:attachment).permit!
  end
end