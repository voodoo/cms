# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190401161715) do

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "site_id",        limit: 4
    t.integer  "contact_id",     limit: 4
    t.string   "action",         limit: 255
    t.integer  "trackable_id",   limit: 4
    t.string   "trackable_type", limit: 255
    t.string   "note",           limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "activities", ["contact_id"], name: "index_activities_on_contact_id", using: :btree
  add_index "activities", ["site_id"], name: "index_activities_on_site_id", using: :btree
  add_index "activities", ["trackable_id"], name: "index_activities_on_trackable_id", using: :btree
  add_index "activities", ["user_id"], name: "index_activities_on_user_id", using: :btree

  create_table "attachments", force: :cascade do |t|
    t.integer  "site_id",            limit: 4
    t.integer  "invoice_id",         limit: 4
    t.string   "title",              limit: 255
    t.boolean  "before_or_after",    limit: 1
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.string   "image_file_size",    limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "position",           limit: 4
    t.integer  "invoice_item_id",    limit: 4
    t.string   "dimensions",         limit: 255
  end

  create_table "blips", force: :cascade do |t|
    t.integer  "site_id",       limit: 4
    t.integer  "user_id",       limit: 4
    t.string   "ip",            limit: 255
    t.string   "submission_id", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "boots", force: :cascade do |t|
    t.integer  "site_id",          limit: 4
    t.integer  "parent_id",        limit: 4
    t.integer  "position",         limit: 4
    t.string   "name",             limit: 255
    t.string   "title",            limit: 255
    t.text     "text",             limit: 65535
    t.boolean  "textile",          limit: 1
    t.string   "type",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",            limit: 255
    t.string   "thumb",            limit: 255
    t.string   "price",            limit: 255
    t.string   "note",             limit: 255
    t.integer  "layout_id",        limit: 4
    t.string   "meta_description", limit: 255
    t.string   "wrapper",          limit: 255,   default: "<div class='container'>{{page_content}}</div>"
    t.string   "meta_keywords",    limit: 255
    t.string   "subtitle",         limit: 255
  end

  add_index "boots", ["layout_id"], name: "index_boots_on_layout_id", using: :btree
  add_index "boots", ["parent_id"], name: "index_boots_on_parent_id", using: :btree
  add_index "boots", ["site_id"], name: "index_boots_on_site_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "site_id",          limit: 4
    t.string   "title",            limit: 50,    default: ""
    t.text     "comment",          limit: 65535
    t.datetime "created_at",                                  null: false
    t.integer  "commentable_id",   limit: 4,     default: 0,  null: false
    t.string   "commentable_type", limit: 15,    default: "", null: false
    t.integer  "user_id",          limit: 4
    t.string   "to_phone",         limit: 255
    t.string   "from_phone",       limit: 255
    t.string   "recording_url",    limit: 255
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["site_id"], name: "index_comments_on_site_id", using: :btree
  add_index "comments", ["user_id"], name: "fk_comments_user", using: :btree

  create_table "comments_users", id: false, force: :cascade do |t|
    t.integer "user_id",    limit: 4
    t.integer "comment_id", limit: 4
  end

  add_index "comments_users", ["comment_id"], name: "index_comments_users_on_comment_id", using: :btree
  add_index "comments_users", ["user_id"], name: "index_comments_users_on_user_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.integer  "site_id",       limit: 4
    t.string   "business_name", limit: 255
    t.string   "first_name",    limit: 255
    t.string   "last_name",     limit: 255
    t.string   "middle_name",   limit: 255
    t.string   "street",        limit: 255
    t.string   "city",          limit: 255
    t.string   "state",         limit: 255
    t.string   "zip",           limit: 255
    t.string   "email",         limit: 255
    t.string   "phone",         limit: 255
    t.string   "other_phone",   limit: 255
    t.string   "cell_phone",    limit: 255
    t.string   "sms",           limit: 255
    t.string   "website",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "emergency",     limit: 1,   default: false
    t.boolean  "demo",          limit: 1,   default: false
    t.integer  "priority",      limit: 4,   default: 0
    t.integer  "submission_id", limit: 4
    t.float    "latitude",      limit: 24
    t.float    "longitude",     limit: 24
  end

  add_index "contacts", ["site_id"], name: "index_contacts_on_site_id", using: :btree

  create_table "contacts_tags", id: false, force: :cascade do |t|
    t.integer "tag_id",     limit: 4
    t.integer "contact_id", limit: 4
  end

  add_index "contacts_tags", ["contact_id"], name: "index_contacts_tags_on_contact_id", using: :btree
  add_index "contacts_tags", ["tag_id"], name: "index_contacts_tags_on_tag_id", using: :btree

  create_table "demos", force: :cascade do |t|
    t.integer  "site_id",       limit: 4
    t.integer  "user_id",       limit: 4
    t.string   "email",         limit: 255
    t.string   "subdomain",     limit: 255
    t.integer  "created_by_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "token",         limit: 255
    t.string   "phone",         limit: 255
    t.string   "pro_phone",     limit: 255
  end

  create_table "domains", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.string   "host",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["host"], name: "index_domains_on_host", unique: true, using: :btree
  add_index "domains", ["site_id"], name: "index_domains_on_site_id", using: :btree

  create_table "estimate_confirmations", force: :cascade do |t|
    t.integer  "invoice_id",               limit: 4
    t.integer  "yes_or_no",                limit: 4
    t.string   "desired_appointment_date", limit: 255
    t.string   "details",                  limit: 255
    t.string   "care_to_share",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.integer  "position",   limit: 4
    t.string   "question",   limit: 255
    t.text     "answer",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "faqs", ["site_id"], name: "index_faqs_on_site_id", using: :btree

  create_table "fields", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.integer  "form_id",    limit: 4
    t.integer  "position",   limit: 4
    t.string   "name",       limit: 255
    t.string   "title",      limit: 255
    t.string   "field_type", limit: 255
    t.string   "value",      limit: 255
    t.string   "options",    limit: 255
    t.boolean  "required",   limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "fields", ["form_id"], name: "index_fields_on_form_id", using: :btree
  add_index "fields", ["site_id"], name: "index_fields_on_site_id", using: :btree

  create_table "folders", force: :cascade do |t|
    t.integer  "site_id",         limit: 4
    t.integer  "position",        limit: 4
    t.string   "name",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "gallery_wrapper", limit: 65535
  end

  add_index "folders", ["site_id"], name: "index_folders_on_site_id", using: :btree

  create_table "forms", force: :cascade do |t|
    t.integer  "site_id",     limit: 4
    t.integer  "position",    limit: 4
    t.string   "name",        limit: 255
    t.string   "title",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description", limit: 65535
    t.text     "wrapper",     limit: 65535
  end

  add_index "forms", ["site_id"], name: "index_forms_on_site_id", using: :btree

  create_table "incoming_calls", force: :cascade do |t|
    t.integer  "site_id",                     limit: 4
    t.integer  "contact_id",                  limit: 4
    t.string   "sid",                         limit: 255
    t.string   "calling",                     limit: 255
    t.string   "called",                      limit: 255
    t.string   "state",                       limit: 255
    t.string   "city",                        limit: 255
    t.string   "zip",                         limit: 255
    t.integer  "duration",                    limit: 4
    t.text     "paths",                       limit: 65535
    t.text     "session",                     limit: 65535
    t.text     "status",                      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "recorded_message_transcript", limit: 1024
    t.string   "caller_name",                 limit: 255
    t.string   "answered_by",                 limit: 255
    t.text     "called_phones",               limit: 65535
    t.string   "recorded_message_url",        limit: 255
    t.string   "recorded_message_duration",   limit: 255
    t.string   "recording_url",               limit: 255
    t.integer  "user_id",                     limit: 4
    t.boolean  "released_from_console",       limit: 1,     default: false
  end

  add_index "incoming_calls", ["called"], name: "index_incoming_calls_on_called", using: :btree
  add_index "incoming_calls", ["calling"], name: "index_incoming_calls_on_caller", using: :btree
  add_index "incoming_calls", ["contact_id"], name: "index_incoming_calls_on_contact_id", using: :btree
  add_index "incoming_calls", ["sid"], name: "index_incoming_calls_on_sid", using: :btree
  add_index "incoming_calls", ["site_id"], name: "index_incoming_calls_on_site_id", using: :btree

  create_table "invoice_item_defaults", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "qty",        limit: 4
    t.decimal  "price",                  precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "site_id",    limit: 4
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer  "invoice_id",              limit: 4
    t.integer  "position",                limit: 4
    t.integer  "qty",                     limit: 4
    t.decimal  "price",                               precision: 10, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "invoice_item_default_id", limit: 4
    t.integer  "site_id",                 limit: 4
    t.string   "note",                    limit: 255
    t.boolean  "publishable",             limit: 1,                            default: true
  end

  create_table "invoice_payment_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "invoice_payments", force: :cascade do |t|
    t.integer  "user_id",                 limit: 4
    t.integer  "invoice_id",              limit: 4
    t.integer  "invoice_payment_type_id", limit: 4
    t.string   "note",                    limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "invoice_statuses", force: :cascade do |t|
    t.integer  "invoice_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "status",     limit: 4
    t.datetime "created_at"
  end

  add_index "invoice_statuses", ["invoice_id"], name: "index_invoice_statuses_on_invoice_id", using: :btree
  add_index "invoice_statuses", ["user_id"], name: "index_invoice_statuses_on_user_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "site_id",         limit: 4
    t.integer  "contact_id",      limit: 4
    t.datetime "paid"
    t.datetime "sent_to_contact"
    t.string   "token",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "footer",          limit: 65535
    t.integer  "view_count",      limit: 4,                              default: 0
    t.boolean  "taxable",         limit: 1,                              default: true
    t.boolean  "estimate",        limit: 1,                              default: true
    t.integer  "status",          limit: 4,                              default: 0
    t.integer  "user_id",         limit: 4
    t.decimal  "tax_rate",                      precision: 10, scale: 5, default: 0.0825
    t.date     "work_date"
    t.string   "work_note",       limit: 255
    t.integer  "received_by",     limit: 4
  end

  add_index "invoices", ["site_id"], name: "index_invoices_on_site_id", using: :btree

  create_table "media", force: :cascade do |t|
    t.integer  "comment_id",   limit: 4
    t.string   "content_type", limit: 255
    t.string   "url",          limit: 255
    t.datetime "created_at"
  end

  create_table "namespaces", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "permission", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "outgoing_calls", force: :cascade do |t|
    t.integer  "site_id",       limit: 4
    t.integer  "contact_id",    limit: 4
    t.integer  "user_id",       limit: 4
    t.string   "contact_phone", limit: 255
    t.string   "sid",           limit: 255
    t.string   "recording_url", limit: 255
    t.integer  "duration",      limit: 4
    t.text     "paths",         limit: 65535
    t.text     "status",        limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "outgoing_calls", ["contact_id"], name: "index_outgoing_calls_on_contact_id", using: :btree
  add_index "outgoing_calls", ["sid"], name: "index_outgoing_calls_on_sid", using: :btree
  add_index "outgoing_calls", ["site_id"], name: "index_outgoing_calls_on_site_id", using: :btree
  add_index "outgoing_calls", ["user_id"], name: "index_outgoing_calls_on_user_id", using: :btree

  create_table "paths", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.string   "session_id", limit: 255
    t.string   "ip",         limit: 255
    t.string   "browser",    limit: 255
    t.string   "url",        limit: 255
    t.string   "referer",    limit: 255
    t.text     "params",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     limit: 4
  end

  add_index "paths", ["session_id"], name: "index_paths_on_session_id", using: :btree
  add_index "paths", ["site_id"], name: "index_paths_on_site_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "module",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["site_id"], name: "index_permissions_on_site_id", using: :btree
  add_index "permissions", ["user_id"], name: "index_permissions_on_user_id", using: :btree

  create_table "phones", force: :cascade do |t|
    t.string   "number",         limit: 255
    t.string   "name",           limit: 255
    t.integer  "site_id",        limit: 4
    t.integer  "phoneable_id",   limit: 4
    t.string   "phoneable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",         limit: 1,   default: true
    t.boolean  "after_five",     limit: 1,   default: true
    t.boolean  "before_five",    limit: 1,   default: true
  end

  add_index "phones", ["phoneable_id"], name: "index_phones_on_phoneable_id", using: :btree
  add_index "phones", ["site_id"], name: "index_phones_on_site_id", using: :btree

  create_table "product_categories", force: :cascade do |t|
    t.integer "site_id",    limit: 4
    t.string  "name",       limit: 255
    t.string  "matrix",     limit: 255
    t.string  "color",      limit: 255
    t.string  "html_color", limit: 255
  end

  create_table "product_inventories", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.string   "note",       limit: 255
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id",    limit: 4,   default: 1
  end

  create_table "product_inventory_items", force: :cascade do |t|
    t.integer "product_inventory_id", limit: 4
    t.integer "product_id",           limit: 4
    t.integer "projected_count",      limit: 4
    t.integer "actual_count",         limit: 4
    t.string  "note",                 limit: 255
  end

  create_table "product_invoice_items", force: :cascade do |t|
    t.integer "product_invoice_id", limit: 4
    t.integer "product_id",         limit: 4
    t.decimal "price",                        precision: 10, scale: 2, default: 0.0
    t.integer "qty",                limit: 4
  end

  create_table "product_invoices", force: :cascade do |t|
    t.integer  "site_id",          limit: 4
    t.integer  "user_id",          limit: 4
    t.string   "note",             limit: 255
    t.boolean  "taxable",          limit: 1,                            default: false
    t.string   "footer",           limit: 255,                          default: "Thank you for your business"
    t.datetime "created_at",                                                                                    null: false
    t.datetime "updated_at",                                                                                    null: false
    t.decimal  "discount",                     precision: 10, scale: 2, default: 0.0,                           null: false
    t.integer  "contact_id",       limit: 4
    t.decimal  "mblz_commission",              precision: 10, scale: 2, default: 0.0,                           null: false
    t.decimal  "sales_commission",             precision: 10, scale: 2, default: 0.0,                           null: false
    t.decimal  "tax_rate",                     precision: 10, scale: 4, default: 0.0825,                        null: false
    t.integer  "paid",             limit: 4,                            default: 0
  end

  create_table "products", force: :cascade do |t|
    t.integer  "site_id",             limit: 4
    t.integer  "product_category_id", limit: 4
    t.string   "name",                limit: 255
    t.string   "size",                limit: 255
    t.decimal  "price",                           precision: 10, scale: 2, default: 0.0
    t.string   "color",               limit: 255
    t.integer  "sun",                 limit: 4
    t.integer  "water",               limit: 4
    t.string   "height",              limit: 255
    t.string   "tolerance",           limit: 255
    t.integer  "inventory",           limit: 4,                            default: 0
    t.integer  "location",            limit: 4
    t.string   "note",                limit: 255
    t.string   "image_file_name",     limit: 255
    t.string   "image_content_type",  limit: 255
    t.string   "image_file_size",     limit: 255
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.boolean  "inactive",            limit: 1,                            default: false
    t.string   "dimensions",          limit: 255
    t.decimal  "cost",                            precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "markup",                          precision: 10, scale: 2, default: 2.0,   null: false
  end

  create_table "recordings", force: :cascade do |t|
    t.integer  "site_id",          limit: 4
    t.integer  "incoming_call_id", limit: 4
    t.string   "url",              limit: 255
    t.integer  "duration",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recordings", ["incoming_call_id"], name: "index_recordings_on_incoming_call_id", using: :btree
  add_index "recordings", ["site_id"], name: "index_recordings_on_site_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "invoice_id",            limit: 4
    t.boolean  "satisfied",             limit: 1
    t.integer  "rating",                limit: 4
    t.text     "comment",               limit: 65535
    t.boolean  "confirmed_by_owner",    limit: 1
    t.boolean  "confirmed_by_customer", limit: 1
    t.datetime "created_at"
    t.string   "title",                 limit: 255
    t.text     "original_comment",      limit: 65535
    t.string   "icon",                  limit: 255,   default: "heart"
  end

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "site_users", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "site_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_users", ["site_id"], name: "index_site_users_on_site_id", using: :btree
  add_index "site_users", ["user_id"], name: "index_site_users_on_user_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "subdomain",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twilio_sid",       limit: 255
    t.string   "twilio_token",     limit: 255
    t.string   "email_from",       limit: 255
    t.string   "email",            limit: 255
    t.string   "sms",              limit: 255
    t.string   "biz_name",         limit: 255
    t.decimal  "tax_rate",                       precision: 10, scale: 5, default: 0.0825
    t.string   "phone",            limit: 255
    t.text     "invoice_footer",   limit: 65535
    t.integer  "copied_site_id",   limit: 4
    t.text     "invoice_wrapper",  limit: 65535
    t.string   "paypal_email",     limit: 255
    t.boolean  "paypal",           limit: 1
    t.string   "owner_name",       limit: 255
    t.string   "owner_street",     limit: 255
    t.string   "owner_city",       limit: 255
    t.string   "owner_state",      limit: 255
    t.string   "owner_zip",        limit: 255
    t.string   "owner_photo",      limit: 255
    t.string   "biz_description",  limit: 255
    t.string   "biz_keywords",     limit: 255
    t.string   "captcha_site",     limit: 255
    t.string   "captcha_secret",   limit: 255
    t.decimal  "mblz_commission",                precision: 10, scale: 2, default: 0.0,    null: false
    t.decimal  "sales_commission",               precision: 10, scale: 2, default: 0.0,    null: false
    t.boolean  "pinned",           limit: 1,                              default: false
  end

  add_index "sites", ["subdomain"], name: "index_sites_on_subdomain", unique: true, using: :btree

  create_table "submissions", force: :cascade do |t|
    t.integer  "form_id",         limit: 4
    t.integer  "site_id",         limit: 4
    t.text     "response",        limit: 65535
    t.string   "ip",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",           limit: 255
    t.string   "suspicious_att",  limit: 255
    t.text     "tracked_session", limit: 65535
  end

  add_index "submissions", ["form_id"], name: "index_submissions_on_form_id", using: :btree
  add_index "submissions", ["site_id"], name: "index_submissions_on_site_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.string   "category",   limit: 255
    t.string   "name",       limit: 255
    t.datetime "created_at"
  end

  add_index "tags", ["site_id"], name: "index_tags_on_site_id", using: :btree

  create_table "twilio_configs", force: :cascade do |t|
    t.integer  "site_id",                  limit: 4
    t.string   "api",                      limit: 255, default: "2008-08-01"
    t.string   "token",                    limit: 255
    t.string   "sid",                      limit: 255
    t.string   "outgoing_phone",           limit: 255
    t.string   "phone",                    limit: 255
    t.string   "ii_phone",                 limit: 255
    t.string   "greeting",                 limit: 255, default: "Thank you for calling. Connecting."
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                    limit: 255
    t.boolean  "call_ii",                  limit: 1
    t.boolean  "call_owner",               limit: 1
    t.boolean  "take_message",             limit: 1
    t.string   "leave_message",            limit: 255
    t.string   "incoming_phone",           limit: 255
    t.integer  "wait_duration",            limit: 4
    t.string   "incoming_toll_free_phone", limit: 255
    t.string   "capability_outgoing",      limit: 255
    t.boolean  "plays_quality_assurance",  limit: 1,   default: true
  end

  add_index "twilio_configs", ["site_id"], name: "index_twilios_on_site_id", using: :btree

  create_table "twilio_logs", force: :cascade do |t|
    t.integer  "site_id",    limit: 4
    t.string   "call_sid",   limit: 255
    t.string   "call_guid",  limit: 255
    t.text     "params",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "site_id",             limit: 4
    t.integer  "folder_id",           limit: 4
    t.string   "upload_file_name",    limit: 255
    t.string   "upload_content_type", limit: 255
    t.string   "upload_file_size",    limit: 255
    t.string   "upload_updated_at",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",               limit: 255
    t.integer  "position",            limit: 4
  end

  add_index "uploads", ["folder_id"], name: "index_uploads_on_folder_id", using: :btree
  add_index "uploads", ["site_id"], name: "index_uploads_on_site_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "role",               limit: 4,   default: 5
    t.string   "email",              limit: 255
    t.string   "crypted_password",   limit: 255
    t.string   "password_salt",      limit: 255
    t.string   "persistence_token",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login",              limit: 255
    t.boolean  "twilio_active",      limit: 1,   default: true
    t.boolean  "twilio_after_five",  limit: 1,   default: false
    t.boolean  "twilio_before_five", limit: 1,   default: false
    t.string   "phone",              limit: 255
    t.boolean  "twilio_weekend",     limit: 1,   default: false
    t.boolean  "active",             limit: 1,   default: true
    t.string   "pin",                limit: 4
  end

  create_table "versions", force: :cascade do |t|
    t.integer  "versioned_id",   limit: 4
    t.string   "versioned_type", limit: 255
    t.text     "changes",        limit: 65535
    t.integer  "number",         limit: 4
    t.datetime "created_at"
  end

  add_index "versions", ["created_at"], name: "index_versions_on_created_at", using: :btree
  add_index "versions", ["number"], name: "index_versions_on_number", using: :btree
  add_index "versions", ["versioned_type", "versioned_id"], name: "index_versions_on_versioned_type_and_versioned_id", using: :btree

  create_table "ways", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "site_id",    limit: 4
    t.decimal  "lat",                    precision: 10, scale: 6
    t.decimal  "lng",                    precision: 10, scale: 6
    t.string   "message",    limit: 255
    t.datetime "created_at"
  end

end
