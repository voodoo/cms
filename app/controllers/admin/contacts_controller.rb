class Admin::ContactsController < MblzController
	require 'csv'
	def index
		export = Contact.export_all(current_site)
		send_data export, :type => 'text/csv; charset=utf-8; header=present', :disposition => "attachment; filename=export_contact_invoices_#{current_site.subdomain}.csv"
	end

end
