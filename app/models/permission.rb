class Permission < ActiveRecord::Base
  belongs_to :site
  belongs_to :user
  MODULES =  %w{Pages Styles Layouts Uploads Folders Forms Faqs Contacts Twilios Dashboard Sites Invoices Iphone Users Domains Paths}
end
