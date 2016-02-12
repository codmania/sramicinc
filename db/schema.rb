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

ActiveRecord::Schema.define(version: 20160124194833) do

  create_table "activities", force: :cascade do |t|
    t.string   "activity",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "banners", force: :cascade do |t|
    t.string   "title",                     limit: 255
    t.string   "url",                       limit: 255
    t.boolean  "active",                    limit: 1,   default: false
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "banner_image_file_name",    limit: 255
    t.string   "banner_image_content_type", limit: 255
    t.integer  "banner_image_file_size",    limit: 4
    t.datetime "banner_image_updated_at"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer  "jobseeker_id", limit: 4
    t.integer  "employer_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "bookmarks", ["employer_id"], name: "index_bookmarks_on_employer_id", using: :btree
  add_index "bookmarks", ["jobseeker_id"], name: "index_bookmarks_on_jobseeker_id", using: :btree

  create_table "careers", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.string   "link",        limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "job_id",       limit: 4
    t.integer  "jobseeker_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "carts", ["job_id"], name: "index_carts_on_job_id", using: :btree
  add_index "carts", ["jobseeker_id"], name: "index_carts_on_jobseeker_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "certifications", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "institution", limit: 255
    t.date     "received"
    t.date     "expired"
    t.integer  "jprofile_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "certifications", ["jprofile_id"], name: "index_certifications_on_jprofile_id", using: :btree

  create_table "city_lists", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "comment",    limit: 65535
    t.integer  "job_id",     limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["job_id"], name: "index_comments_on_job_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "country_lists", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "disciplines", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "education_lists", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "educations", force: :cascade do |t|
    t.string   "degree",      limit: 255
    t.string   "field",       limit: 255
    t.string   "institution", limit: 255
    t.text     "location",    limit: 65535
    t.string   "completion",  limit: 255
    t.integer  "jprofile_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "educations", ["jprofile_id"], name: "index_educations_on_jprofile_id", using: :btree

  create_table "email_templates", force: :cascade do |t|
    t.text     "subject",     limit: 65535
    t.text     "body",        limit: 65535
    t.integer  "employer_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "email_templates", ["employer_id"], name: "index_email_templates_on_employer_id", using: :btree

  create_table "employers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "employers", ["user_id"], name: "index_employers_on_user_id", using: :btree

  create_table "enquiries", force: :cascade do |t|
    t.integer  "enquiry_category_id", limit: 4
    t.string   "name",                limit: 255
    t.string   "email",               limit: 255
    t.text     "description",         limit: 65535
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "status",              limit: 255,   default: "pending"
    t.date     "respond_date"
  end

  add_index "enquiries", ["enquiry_category_id"], name: "index_enquiries_on_enquiry_category_id", using: :btree

  create_table "enquiry_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "eprofiles", force: :cascade do |t|
    t.string   "company_name",      limit: 255
    t.integer  "industry_id",       limit: 4
    t.text     "address1",          limit: 65535
    t.text     "address2",          limit: 65535
    t.string   "city",              limit: 255
    t.integer  "state_list_id",     limit: 4
    t.integer  "country_list_id",   limit: 4
    t.string   "phone",             limit: 255
    t.string   "fax",               limit: 255
    t.text     "website",           limit: 65535
    t.string   "email",             limit: 255
    t.text     "overview",          limit: 65535
    t.text     "products",          limit: 65535
    t.text     "services",          limit: 65535
    t.text     "fb_url",            limit: 65535
    t.text     "twitter_url",       limit: 65535
    t.text     "gplus_url",         limit: 65535
    t.text     "linkedin_url",      limit: 65535
    t.integer  "employer_id",       limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
    t.boolean  "active",            limit: 1,     default: true
    t.boolean  "deleted",           limit: 1,     default: false
    t.boolean  "publicviewing",     limit: 1,     default: true
  end

  add_index "eprofiles", ["country_list_id"], name: "index_eprofiles_on_country_list_id", using: :btree
  add_index "eprofiles", ["employer_id"], name: "index_eprofiles_on_employer_id", unique: true, using: :btree
  add_index "eprofiles", ["industry_id"], name: "index_eprofiles_on_industry_id", using: :btree
  add_index "eprofiles", ["state_list_id"], name: "index_eprofiles_on_state_list_id", using: :btree

  create_table "experience_sectors", force: :cascade do |t|
    t.integer  "job_history_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "faq_categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "faqs", force: :cascade do |t|
    t.integer  "faq_category_id", limit: 4
    t.text     "question",        limit: 65535
    t.text     "answer",          limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "faqs", ["faq_category_id"], name: "index_faqs_on_faq_category_id", using: :btree

  create_table "grades", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "industries", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "jcontacts", force: :cascade do |t|
    t.text     "message",            limit: 65535
    t.integer  "employer_id",        limit: 4
    t.integer  "job_application_id", limit: 4
    t.integer  "thread_parent",      limit: 4
    t.boolean  "is_read",            limit: 1,     default: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "jcontacts", ["employer_id"], name: "index_jcontacts_on_employer_id", using: :btree
  add_index "jcontacts", ["job_application_id"], name: "index_jcontacts_on_job_application_id", using: :btree

  create_table "job_alerts", force: :cascade do |t|
    t.string   "what",       limit: 255
    t.string   "where",      limit: 255
    t.string   "within",     limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "job_alerts", ["user_id"], name: "index_job_alerts_on_user_id", using: :btree

  create_table "job_applications", force: :cascade do |t|
    t.integer  "jobseeker_id", limit: 4
    t.integer  "job_id",       limit: 4
    t.string   "status",       limit: 255, default: "pending"
    t.integer  "jcontact_id",  limit: 4
    t.boolean  "contact",      limit: 1,   default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "job_applications", ["job_id"], name: "index_job_applications_on_job_id", using: :btree
  add_index "job_applications", ["jobseeker_id"], name: "index_job_applications_on_jobseeker_id", using: :btree

  create_table "job_histories", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.string   "organization",   limit: 255
    t.boolean  "currentcompany", limit: 1
    t.date     "from"
    t.date     "to"
    t.integer  "jprofile_id",    limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "job_histories", ["jprofile_id"], name: "index_job_histories_on_jprofile_id", using: :btree

  create_table "job_lengths", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "job_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "title",             limit: 255
    t.integer  "employer_id",       limit: 4
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.text     "description",       limit: 65535
    t.string   "education",         limit: 255
    t.string   "experience",        limit: 255,   default: "0"
    t.integer  "industry_id",       limit: 4
    t.string   "keywords",          limit: 255
    t.string   "city",              limit: 255
    t.integer  "state_list_id",     limit: 4
    t.integer  "country_list_id",   limit: 4
    t.string   "zip",               limit: 255
    t.integer  "job_type_id",       limit: 4
    t.integer  "salary_type_id",    limit: 4
    t.string   "salary",            limit: 255
    t.integer  "job_length",        limit: 4
    t.boolean  "relocation",        limit: 1
    t.string   "certification",     limit: 255
    t.string   "clearance",         limit: 255
    t.integer  "category_id",       limit: 4
    t.string   "references",        limit: 255
    t.boolean  "status",            limit: 1,     default: true
    t.float    "latitude",          limit: 24
    t.float    "longitude",         limit: 24
    t.text     "plain_description", limit: 65535
    t.boolean  "deleted",           limit: 1,     default: false
  end

  add_index "jobs", ["category_id"], name: "index_jobs_on_category_id", using: :btree
  add_index "jobs", ["country_list_id"], name: "index_jobs_on_country_list_id", using: :btree
  add_index "jobs", ["employer_id"], name: "index_jobs_on_employer_id", using: :btree
  add_index "jobs", ["industry_id"], name: "index_jobs_on_industry_id", using: :btree
  add_index "jobs", ["job_type_id"], name: "index_jobs_on_job_type_id", using: :btree
  add_index "jobs", ["salary_type_id"], name: "index_jobs_on_salary_type_id", using: :btree
  add_index "jobs", ["state_list_id"], name: "index_jobs_on_state_list_id", using: :btree

  create_table "jobseekers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.boolean  "active",     limit: 1,   default: true
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "jobseekers", ["user_id"], name: "index_jobseekers_on_user_id", using: :btree

  create_table "journals", force: :cascade do |t|
    t.text     "name",        limit: 65535
    t.date     "date"
    t.text     "reference",   limit: 65535
    t.integer  "jprofile_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "journals", ["jprofile_id"], name: "index_journals_on_jprofile_id", using: :btree

  create_table "jprofiles", force: :cascade do |t|
    t.string   "availability",        limit: 255
    t.boolean  "relocation",          limit: 1
    t.string   "title",               limit: 255
    t.string   "name",                limit: 255
    t.string   "phone",               limit: 255
    t.text     "address1",            limit: 65535
    t.text     "address2",            limit: 65535
    t.string   "city",                limit: 255
    t.integer  "state_list_id",       limit: 4
    t.integer  "country_list_id",     limit: 4
    t.string   "zip",                 limit: 255
    t.integer  "salary_type_id",      limit: 4
    t.string   "salary",              limit: 255
    t.float    "latitude",            limit: 24
    t.float    "longitude",           limit: 24
    t.integer  "jobseeker_id",        limit: 4
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "resume_headline",     limit: 255
    t.string   "resume_file_name",    limit: 255
    t.string   "resume_content_type", limit: 255
    t.integer  "resume_file_size",    limit: 4
    t.datetime "resume_updated_at"
    t.string   "logo_file_name",      limit: 255
    t.string   "logo_content_type",   limit: 255
    t.integer  "logo_file_size",      limit: 4
    t.datetime "logo_updated_at"
    t.text     "summary",             limit: 65535
    t.boolean  "publicviewing",       limit: 1,     default: true
    t.boolean  "deleted",             limit: 1,     default: false
    t.boolean  "active",              limit: 1,     default: true
  end

  add_index "jprofiles", ["country_list_id"], name: "index_jprofiles_on_country_list_id", using: :btree
  add_index "jprofiles", ["jobseeker_id"], name: "index_jprofiles_on_jobseeker_id", using: :btree
  add_index "jprofiles", ["salary_type_id"], name: "index_jprofiles_on_salary_type_id", using: :btree
  add_index "jprofiles", ["state_list_id"], name: "index_jprofiles_on_state_list_id", using: :btree

  create_table "networks", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "me",         limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "networks", ["user_id"], name: "index_networks_on_user_id", using: :btree

  create_table "news_letters", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.boolean  "active",     limit: 1,   default: true
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "user_id",    limit: 255
    t.string   "url",        limit: 255
    t.string   "n_type",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "payment_infos", force: :cascade do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "transaction_id",        limit: 255
    t.string   "parent_transaction_id", limit: 255
    t.string   "receipt_id",            limit: 255
    t.string   "transaction_type",      limit: 255
    t.string   "payment_type",          limit: 255
    t.date     "payment_date"
    t.float    "gross_amount",          limit: 24
    t.float    "fee_amount",            limit: 24
    t.float    "tax_amount",            limit: 24
    t.string   "exchange_rate",         limit: 255
    t.string   "payment_status",        limit: 255
    t.string   "pending_reason",        limit: 255
    t.string   "reason_code",           limit: 255
    t.integer  "subscription_id",       limit: 4
  end

  add_index "payment_infos", ["subscription_id"], name: "index_payment_infos_on_subscription_id", using: :btree

  create_table "payment_modules", force: :cascade do |t|
    t.boolean  "active",     limit: 1, default: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.float    "price",           limit: 24,  default: 0.0
    t.float    "days",            limit: 24,  default: 0.0
    t.string   "description",     limit: 255
    t.string   "plan_type",       limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "job_post",        limit: 4
    t.integer  "resume_database", limit: 4
    t.integer  "user_account",    limit: 4
    t.boolean  "analytics",       limit: 1,   default: false
    t.boolean  "email_support",   limit: 1,   default: false
    t.boolean  "phone_support",   limit: 1,   default: false
    t.boolean  "api",             limit: 1,   default: false
    t.boolean  "profile_alert",   limit: 1,   default: false
  end

  create_table "portfolios", force: :cascade do |t|
    t.string   "name",              limit: 255
    t.text     "url",               limit: 65535
    t.integer  "jprofile_id",       limit: 4
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
  end

  add_index "portfolios", ["jprofile_id"], name: "index_portfolios_on_jprofile_id", using: :btree

  create_table "profile_hires", force: :cascade do |t|
    t.integer  "employer_id",  limit: 4
    t.integer  "jprofile_id",  limit: 4
    t.boolean  "is_recruited", limit: 1, default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "profile_hires", ["employer_id"], name: "index_profile_hires_on_employer_id", using: :btree
  add_index "profile_hires", ["jprofile_id"], name: "index_profile_hires_on_jprofile_id", using: :btree

  create_table "qualifications", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "questionaires", force: :cascade do |t|
    t.text     "question",    limit: 65535
    t.text     "answer",      limit: 65535
    t.integer  "user_id",     limit: 4
    t.integer  "eprofile_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "questionaires", ["eprofile_id"], name: "index_questionaires_on_eprofile_id", using: :btree
  add_index "questionaires", ["user_id"], name: "index_questionaires_on_user_id", using: :btree

  create_table "review_responses", force: :cascade do |t|
    t.integer  "from",       limit: 4
    t.integer  "review_id",  limit: 4
    t.text     "response",   limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "review_responses", ["review_id"], name: "index_review_responses_on_review_id", using: :btree

  create_table "reviews", force: :cascade do |t|
    t.integer  "from",            limit: 4
    t.text     "pros",            limit: 65535
    t.text     "cons",            limit: 65535
    t.text     "recommendations", limit: 65535
    t.integer  "to",              limit: 4
    t.string   "ratings",         limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "score",           limit: 4,     default: 0
  end

  add_index "reviews", ["from"], name: "index_reviews_on_from", using: :btree
  add_index "reviews", ["to"], name: "index_reviews_on_to", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "authority",  limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "salaries", force: :cascade do |t|
    t.string   "amount",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "salary_types", force: :cascade do |t|
    t.string   "s_type",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "search_filters", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "criteria",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "security_questions", force: :cascade do |t|
    t.string "locale", limit: 255, null: false
    t.string "name",   limit: 255, null: false
  end

  create_table "shares", force: :cascade do |t|
    t.text     "news",        limit: 65535
    t.integer  "eprofile_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "skill_sets", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string   "year_of_experience", limit: 255, default: "0"
    t.string   "name",               limit: 255
    t.integer  "jprofile_id",        limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "skills", ["jprofile_id"], name: "index_skills_on_jprofile_id", using: :btree

  create_table "state_lists", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "country_list_id", limit: 4
  end

  add_index "state_lists", ["country_list_id"], name: "index_state_lists_on_country_list_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "plan_id",    limit: 4
    t.integer  "user_id",    limit: 4
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "talent_alerts", force: :cascade do |t|
    t.string   "what",       limit: 255
    t.string   "where",      limit: 255
    t.string   "within",     limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "talent_alerts", ["user_id"], name: "index_talent_alerts_on_user_id", using: :btree

  create_table "testimonials", force: :cascade do |t|
    t.string   "user_id",           limit: 255
    t.string   "name",              limit: 255
    t.string   "email",             limit: 255
    t.string   "company",           limit: 255
    t.text     "description",       limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
  end

  add_index "testimonials", ["user_id"], name: "index_testimonials_on_user_id", using: :btree

  create_table "universities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                    limit: 255, default: "",   null: false
    t.string   "encrypted_password",       limit: 255, default: "",   null: false
    t.string   "name",                     limit: 255, default: "",   null: false
    t.string   "reset_password_token",     limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            limit: 4,   default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",       limit: 255
    t.string   "last_sign_in_ip",          limit: 255
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
    t.integer  "role_id",                  limit: 4
    t.string   "provider",                 limit: 255
    t.string   "uid",                      limit: 255
    t.string   "captcha",                  limit: 255
    t.string   "captcha_key",              limit: 255
    t.integer  "failed_attempts",          limit: 4,   default: 0
    t.string   "unlock_token",             limit: 255
    t.datetime "locked_at"
    t.integer  "security_question_id",     limit: 4
    t.string   "security_question_answer", limit: 255
    t.string   "confirmation_token",       limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",        limit: 255
    t.boolean  "active",                   limit: 1,   default: true
    t.integer  "employer_id",              limit: 4
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "watch_lists", force: :cascade do |t|
    t.integer  "job_id",       limit: 4
    t.integer  "jobseeker_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "watch_lists", ["job_id"], name: "index_watch_lists_on_job_id", using: :btree
  add_index "watch_lists", ["jobseeker_id"], name: "index_watch_lists_on_jobseeker_id", using: :btree

end
