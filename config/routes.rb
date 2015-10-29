Rails.application.routes.draw do

  get 'job_api/index'
  get 'job_api/get_all_jobs'
  get 'job_api/get_job'


  resources :email_templates
  resources :plans
  resources :subscriptions
 resources :payments do
   collection do
      get  'return_url'
      get  'cancel_url'
      get 'checkout'
      get 'transfer_amount'
      get 'pricing'
       get 'jobseekerpricing'
   end
 end


  resources :staffs
  post 'staffs/active_deactive'

  get 'sitemap/index'
  #get 'careers_path' => 'careers#index'
  resources :careers
  post '/careers/:id', to: 'careers#update'
  mount Ckeditor::Engine => '/ckeditor'
  get 'page/about'

  resources :banners
 post '/faqs/:id', to: 'faqs#update'
  resources :faq_categories
  resources :faqs
  resources :review_responses

  resources :enquiries
  resources :enquiry_categories

  resources :news_letters
  get 'review_responses/create'
  resources :review_responses
  resources :salary_types
  resources :job_types
  resources :industries
  resources :categories
  resources :city_lists
  resources :country_lists
  resources :state_lists
  resources :app_users
  resources :notifications
  resources :job_alerts
  resources :talent_alerts
  resources :profile_hires
  resources :networks
  resources :bookmarks
  resources :reviews
  #resources :jobseekers
  resources :watch_lists
  resources :job_applications
  resources :carts
  resources :journals
  resources :certifications
  resources :activities
  resources :portfolios
  resources :comments
  resources :testimonials
#  resources :pages

#  get 'admin/cms'
  get '/admin/cms/:id', to: 'admin#cms'
  patch '/admin/cms/:id', to: 'admin#cms', as: 'page'

  get '/admin/cms_pages', to: 'admin#cms_pages'

  #static pages
  get 'page/about'
  get 'page/home_page_banner'
 # get 'payments/jobseekerpricing'=>'payments#jobseekerpricing'
  get 'payment_modules/edit'
  get 'payment_modules/update'
 get 'enquiries/contactus'=>'enquiries#contactus'

  post 'news_letters/news_letter'=>'news_letters#news_letter'


  post 'app_users/active_deactive'
  post 'news_letters/active_deactive'=>'news_letters_active_deactive_path'
  post 'banners/active_deactive'=>'banners_active_deactive_path'
  post 'news_letters/send_news_letter'
  post 'employer/contact'


  get 'jobseeker_addreview_details'=>'jobseeker#addreview_details'
  get 'employer_addreview_to_jobseeker'=>'employer#addreview_to_jobseeker'

  get 'review_list_employer'=>'employer#review_list'
  get 'review_list_jobseeker'=>'jobseeker#review_list'
  get 'message_list_jobseeker'=>'jobseeker#message_list'
  get 'employer/summary'

  post 'jobseeker/addreview'
  post 'employer/addreview'
  get 'employer/index'
  get 'admin/index'
  post 'jobs/addtocart'
  post 'jobs/add_to_watchlist'
  post 'jobs/apply_job'
  get 'jobs/job_eprofile'
  post 'carts/applyJob'
  post 'carts/apply_all_jobs'
  get 'update_job_status'=>'job_applications#update_status'
  get 'employer/addtobookmark'
  get 'employer/addtonetwork'
  post 'contact_candidate'=>'employer#contact_candidate'
  post 'hire'=>'employer#hire_candidate'
  get 'more_comments'=>'comments#more_comments'

  post 'reviews/review_respond'
  post 'enquiries/message_respond'

  post 'country_lists/country_list_update'
  get 'update_enquiry_status'=>'enquiries#update_status'

  get 'search/jobs'=>'search#search_jobs'
  get 'search/profiles'=>'search#search_profiles'
  get 'search/search_local_employers' => 'search#search_local_employers'
  get 'search/search_local_talents' => 'search#search_local_talents'
  get 'search/save_search_criteria' => 'search#save_search_criteria'
  post 'search/delete_search_criteria' => 'search#delete_search_criteria'

  get 'my_jobs'=>'employer#my_jobs'
  get 'applications'=>'employer#job_applications'
  get 'employer/talents'=>'employer#talents'
  get 'enquiries_list_enquiries'=>'enquiries#enquiries_list'


  captcha_route
  resources :jobseeker
  resources :jobs
  resources :skills
  resources :job_histories
  resources :qualifications
  resources :educations
  resources :eprofiles
  #resources :search

  match 'socialemail/email'=>'socialemail#email', via: [:get, :post]

  get 'jobseeker'=>'jobseeker#index', as: :j_home
  get 'employer'=>'employer#index', as: :e_home
  get 'admin'=>'admin#index', as: :a_home

  get "forgot_password" => "passwords#forgot"
  match "forgot_password/email_check" => "passwords#email_check", via: [:get, :post]
  get "forgot_password/verify_question" => "passwords#verify_question"
  post "forgot_password/verify_answer" => "passwords#verify_answer"
  get "forgot_password/reset_password" => "passwords#reset"
  put "forgot_password/reset_save" => "passwords#reset_save"

  post "jprofiles/download_resume"

  resources :jprofiles do
      resources :educations, :skills, :job_histories, :portfolios, :shallow=>true
  end
    # match "employer_register" => "users/registrations#employer", :as => :new_employer_registration
  get 'home/index'

  devise_for :users, controllers: { sessions: "users/sessions",registrations:"users/registrations", :omniauth_callbacks => "users/omniauth_callbacks",:confirmations => "users/confirmations",:passwords=>"users/passwords" }
  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get 'employer_registration', to: 'users/registrations#employer_registration'
  end


  root 'home#index'

end
