
if !Role.exists?
  admin_role=Role.create authority:'admin'
  employer_role=Role.create authority:'employer'
  jobseeker_role=Role.create authority:'jobseeker'
end

if Role.find_by(authority: 'staff').nil?
  staff_role=Role.create authority:'staff'
end


if !Plan.exists?

  Plan.create(name: 'FREE', price: 0, days: nil, description: 'This is Free plan of Employer', plan_type: 'Employer', job_post: 1, resume_database: 10, user_account: 1, analytics: true, email_support: true, phone_support: false, api: false, profile_alert: false)
  Plan.create(name: 'Monthly', price: 60, days: 30, description: 'This is Monthly plan of Employer', plan_type: 'Employer', job_post: -1, resume_database: -1, user_account: -1, analytics: true, email_support: true, phone_support: true, api: true, profile_alert: true)
  Plan.create(name: 'Quarterly', price: 150, days: 90, description: 'This is Quarterly plan of Employer', plan_type: 'Employer', job_post: -1, resume_database: -1, user_account: -1, analytics: true, email_support: true, phone_support: true, api: true, profile_alert: true)
  Plan.create(name: 'HalfYearly', price: 250, days:180, description: 'This is HalfYearly plan of Employer', plan_type: 'Employer', job_post: -1, resume_database: -1, user_account: -1, analytics: true, email_support: true, phone_support: true, api: true, profile_alert: true)
  Plan.create(name: 'Yearly', price: 365, days: 365, description: 'This is Yearly plan of Employer', plan_type: 'Employer', job_post: -1, resume_database: -1, user_account: -1, analytics: true, email_support: true, phone_support: true, api: true, profile_alert: true)

  Plan.create(name: 'FREE', price: 0, days: nil, description: 'This is Free plan of Jobseeker', plan_type: 'Jobseeker', job_post: 100, resume_database: 100, user_account: 100, analytics: true, email_support: false, phone_support: false, api: false, profile_alert: false)
  Plan.create(name: 'Monthly', price: 4.99, days: 30, description: 'This is Monthly plan of Jobseeker', plan_type: 'Jobseeker', job_post: 2000, resume_database: 2000, user_account: 2000, analytics: true, email_support: true, phone_support: true, api: true, profile_alert: true)
  Plan.create(name: 'Quarterly', price: 9.99, days: 90, description: 'This is Quarterly plan of Jobseeker', plan_type: 'Jobseeker', job_post: 3000, resume_database: 3000, user_account: 3000, analytics: true, email_support: true, phone_support: true, api: true, profile_alert: true)
  Plan.create(name: 'HalfYearly', price: 14.99, days:180, description: 'This is HalfYearly plan of Jobseeker', plan_type: 'Jobseeker', job_post: 5000, resume_database: 5000, user_account: 5000, analytics: true, email_support: true, phone_support: true, api: true, profile_alert: true)
  Plan.create(name: 'Yearly', price: 24.99, days: 365, description: 'This is Yearly plan of Jobseeker', plan_type: 'Jobseeker', job_post: 0, resume_database: 0, user_account: 0, analytics: true, email_support: true, phone_support: true, api: true, profile_alert: true)
end


if PaymentModule.first.nil?
  PaymentModule.create
end


if !JobType.exists?
  job_type_1=JobType.create name:'Full-Time'
  job_type_2=JobType.create name:'Part-Time'
  job_type_3=JobType.create name:'Contract'
  job_type_4=JobType.create name:'Internship'
  job_type_5=JobType.create name:'Temporary'
  job_type_6=JobType.create name:'Entry Level'
  job_type_7=JobType.create name:'Commission'
  job_type_8=JobType.create name:'Trainee'  
end

if !User.find_by(email: 'bindas@sramic.com', role_id: 1).present?
  admin = User.create email:'bindas@sramic.com', password:'Ebindas@1979',password_confirmation:'Ebindas@1979',role_id:1,confirmed_at:Date.today,name:'admin user'
end

if !User.find_by(email: 'employer@gmail.com').present?
  emp=User.create email:'employer@gmail.com', password:'Sigma@123',password_confirmation:'Sigma@123',role_id:2,confirmed_at:Date.today,name:'employer1'
end

if !User.find_by(email: 'employer2@gmail.com').present?
  emp=User.create email:'employer2@gmail.com', password:'Sigma@123',password_confirmation:'Sigma@123',role_id:2,confirmed_at:Date.today,name:'employer2'
end

if !User.find_by(email: 'jobseeker1@gmail.com').present?
  jobseeker_user1=User.create email:'jobseeker1@gmail.com', password:'Sigma@123',password_confirmation:'Sigma@123',role_id:3,confirmed_at:Date.today,name:'jobseeker 1'
end


#['Accounting','Bank','Transport','Insurance','IT'].each {|industry|
#  Industry.find_or_create_by({name: industry})
#}

['Agriculture','Accounting','Administration','Airline','Apparel & Accessories','Architecture','Automotive','Banking','Broadcasting','Brokerage','Biotechnology','Call Center','Cargo Handling','Charity','Chemical','Computer','Construction','Constomer Service','Consulting','Cosmetics','Defense','Department Stores','Education','Electronics','Engineering','Energy','Entertainment & Leisure','Executive Search','Finance','Financial Services','Food Beverage & Tobacco','Grocery','Hardware','Healthcare','Hospital','HR','Insurance','IT Software','Internet Publishing','Investment Banking','Legal','Logistics','Management','Manufacturing','Marketing','Media & Video','Music','Newspaper Publishers','Nursing','Oil & Gas','Online Auctions','Pension Funds','Pharmaceuticals','PrivateEquity','PublicSector','Publishing','RealEstate','Retail & Wholesale','Sales','Science','Securities & Commodity Exchanges','Social','Service','Sports','Teaching','Technology','Telecommunications','Television','Trading','Transportation','Travel','Trucking','Venture Capital','Wholesale','Writing'].each {|industry|
  Industry.find_or_create_by({name: industry})
}


if !SalaryType.exists?
  SalaryType.create(s_type: 'Annual Salary' )
  SalaryType.create(s_type: 'Monthly Rate')
  SalaryType.create(s_type: 'Weekly Rate')
  SalaryType.create(s_type: 'Daily Rate')
  SalaryType.create(s_type: 'Hourly Rate')
end


if !CountryList.exists?
  countrylist = CountryList.create(name: 'US')
  #CountryList.create(name: 'India')
end

if !StateList.exists?
  StateList.create(name: 'AK', country_list_id: countrylist.id)
  StateList.create(name: 'AL', country_list_id: countrylist.id)
  StateList.create(name: 'AR', country_list_id: countrylist.id)
  StateList.create(name: 'AZ', country_list_id: countrylist.id)
  StateList.create(name: 'CA', country_list_id: countrylist.id)
  StateList.create(name: 'CO', country_list_id: countrylist.id)
  StateList.create(name: 'CT', country_list_id: countrylist.id)
  StateList.create(name: 'DC', country_list_id: countrylist.id)
  StateList.create(name: 'DE', country_list_id: countrylist.id)
  StateList.create(name: 'FL', country_list_id: countrylist.id)
  StateList.create(name: 'GA', country_list_id: countrylist.id)
  StateList.create(name: 'HI', country_list_id: countrylist.id)
  StateList.create(name: 'IA', country_list_id: countrylist.id)
  StateList.create(name: 'ID', country_list_id: countrylist.id)
  StateList.create(name: 'IL', country_list_id: countrylist.id)
  StateList.create(name: 'IN', country_list_id: countrylist.id)
  StateList.create(name: 'KS', country_list_id: countrylist.id)
  StateList.create(name: 'KY', country_list_id: countrylist.id)
  StateList.create(name: 'LA', country_list_id: countrylist.id)
  StateList.create(name: 'MA', country_list_id: countrylist.id)
  StateList.create(name: 'MD', country_list_id: countrylist.id)
  StateList.create(name: 'ME', country_list_id: countrylist.id)
  StateList.create(name: 'MI', country_list_id: countrylist.id)
  StateList.create(name: 'MN', country_list_id: countrylist.id)
  StateList.create(name: 'MO', country_list_id: countrylist.id)
  StateList.create(name: 'MS', country_list_id: countrylist.id)
  StateList.create(name: 'MT', country_list_id: countrylist.id)
  StateList.create(name: 'NC', country_list_id: countrylist.id)
  StateList.create(name: 'ND', country_list_id: countrylist.id)
  StateList.create(name: 'NE', country_list_id: countrylist.id)
  StateList.create(name: 'NH', country_list_id: countrylist.id)
  StateList.create(name: 'NJ', country_list_id: countrylist.id)
  StateList.create(name: 'NM', country_list_id: countrylist.id)
  StateList.create(name: 'NV', country_list_id: countrylist.id)
  StateList.create(name: 'NY', country_list_id: countrylist.id)
  StateList.create(name: 'OH', country_list_id: countrylist.id)
  StateList.create(name: 'OK', country_list_id: countrylist.id)
  StateList.create(name: 'OR', country_list_id: countrylist.id)
  StateList.create(name: 'PA', country_list_id: countrylist.id)
  StateList.create(name: 'RI', country_list_id: countrylist.id)
  StateList.create(name: 'SC', country_list_id: countrylist.id)
  StateList.create(name: 'SD', country_list_id: countrylist.id)
  StateList.create(name: 'TN', country_list_id: countrylist.id)
  StateList.create(name: 'TX', country_list_id: countrylist.id)
  StateList.create(name: 'UT', country_list_id: countrylist.id)
  StateList.create(name: 'VA', country_list_id: countrylist.id)
  StateList.create(name: 'VT', country_list_id: countrylist.id)
  StateList.create(name: 'WA', country_list_id: countrylist.id)
  StateList.create(name: 'WI', country_list_id: countrylist.id)
  StateList.create(name: 'WV', country_list_id: countrylist.id)
  StateList.create(name: 'WY', country_list_id: countrylist.id)
end


if !EnquiryCategory.exists?
  EnquiryCategory.create(name: 'Looking for a job')
  EnquiryCategory.create(name: 'My CV-Upload/Edit/Delete/Retrive')
  EnquiryCategory.create(name: 'My Profile')
  EnquiryCategory.create(name: 'Unable to login')
  EnquiryCategory.create(name: 'Unsubscibe')
end

if !FaqCategory.exists?
  @cate_1 = FaqCategory.create(name: 'Registration questions')
  @cate_2 = FaqCategory.create(name: 'Jobseeker Profile questions')
  @cate_3 = FaqCategory.create(name: 'Application questions')
  @cate_4 = FaqCategory.create(name: 'Job Posting ')
  @cate_5 = FaqCategory.create(name: 'Search')
end


if Page.find_by(name: 'About').nil?
  aboutPage=Page.new
  aboutPage.name='About'
  aboutPage.content='<p><span style="font-size:20px;"><strong><span style="color:#DAA520;">About us</span></strong></span>&nbsp;</p><p>Hi&nbsp;<span style="line-height: 1.6;">this is my abt page</span></p><p>&nbsp;</p>'

  aboutPage.save
end


# if Page.find_by(name: 'Home Banner').nil?
#   home_page_banner=Page.new
#   home_page_banner.name='Home Banner'
#   home_page_banner.content=''

#   home_page_banner.save
# end


# if Page.find_by(name: 'Home Banner Heading').nil?
#   home_page_banner_heading=Page.new
#   home_page_banner_heading.name='Home Banner Heading'
#   home_page_banner_heading.content='<h2> What You Do Makes You, So Come And Join The Right Platform </h2>'

#   home_page_banner_heading.save
# end


if Page.find_by(name: 'Employer Content').nil?
  employer_content=Page.new
  employer_content.name='Employer Content'
  employer_content.content="<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.</p>"

  employer_content.save
end


if Page.find_by(name: 'Candidate Content').nil?
  candidate_content=Page.new
  candidate_content.name='Candidate Content'
  candidate_content.content="<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.</p>"

  candidate_content.save
end

if Page.find_by(name: 'Testimonial Header').nil?
  testimonial_header=Page.new
  testimonial_header.name='Testimonial Header'
  testimonial_header.content="<h3>Happy Campers</h3><h4>What people thought about our service!!!</h4>"

  testimonial_header.save
end

if Page.find_by(name: 'Footer Social Header').nil?
  footer_social_header=Page.new
  footer_social_header.name='Footer Social Header'
  footer_social_header.content="<h3>Join The Right Platform</h3>
        <p>It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. </p>"

  footer_social_header.save
end

if !Category.exists?
   Category.create(name: 'Agriculture')
   Category.create(name: 'Accounting')
   # Category.create(name: 'Administration')
  #  Category.create(name: 'Airline')
  #  Category.create(name: 'Apparel & Accessories')
  #  Category.create(name: 'Architecture')
  #  Category.create(name: 'Automotive')
  #  Category.create(name: 'Banking')
  #  Category.create(name: 'Broadcasting')
  #  Category.create(name: 'Brokerage')
  #  Category.create(name: 'Biotechnology')
  #  Category.create(name: 'CallCenters')
  #  Category.create(name: 'CargoHandling')
  #  Category.create(name: 'Charity')
  #  Category.create(name: 'Chemical')
  #  Category.create(name: 'Computer')
  #  Category.create(name: 'Construction')
  #  Category.create(name: 'Constomer Service')
  #  Category.create(name: 'Consulting')
  #  Category.create(name: 'Cosmetics')
  #  Category.create(name: 'Defense')
  #  Category.create(name: 'Department Stores')
  #  Category.create(name: 'Education')
  #  Category.create(name: 'Electronics')
  #  Category.create(name: 'Engineering')
  #  Category.create(name: 'Energy')
  #  Category.create(name: 'Entertainment & Leisure')
  #  Category.create(name: 'Executive Search')
  #  Category.create(name: 'Finance')
  #  Category.create(name: 'Financial Services')
  #  Category.create(name: 'Food,Beverage&Tobacco')
  #  Category.create(name: 'Grocery')
  #  Category.create(name: 'Hardware')
  #  Category.create(name: 'Healthcare')
  #  Category.create(name: 'Hospital')
  #  Category.create(name: 'HR')
  #  Category.create(name: 'Insurance')
  #  Category.create(name: 'IT & Software')
  #  Category.create(name: 'Internet Publishing')
  #  Category.create(name: 'Investment Banking')
  #  Category.create(name: 'Legal')
  #  Category.create(name: 'Logistics')
  #  Category.create(name: 'Management')
  #  Category.create(name: 'Manufacturing')
  #  Category.create(name: 'Marketing')
  #  Category.create(name: 'Media&Video')
  #  Category.create(name: 'Music')
  #  Category.create(name: 'Newspaper Publishers')
  #  Category.create(name: 'Nursing')
  #  Category.create(name: 'Oil & Gas')
  #  Category.create(name: 'Online Auctions')
  #  Category.create(name: 'Pension Funds')
  #  Category.create(name: 'Pharmaceuticals')
  #  Category.create(name: 'PrivateEquity')
  #  Category.create(name: 'PublicSector')
  #  Category.create(name: 'Publishing')
  #  Category.create(name: 'RealEstate')
  #  Category.create(name: 'Retail&Wholesale')
  #  Category.create(name: 'Sales')
  #  Category.create(name: 'Science')
  #  Category.create(name: 'Securities & Commodity Exchanges')
  #  Category.create(name: 'Social')
  #  Category.create(name: 'Service')
  #  Category.create(name: 'Sports')
  #  Category.create(name: 'Teaching')
  #  Category.create(name: 'Technology')
  #  Category.create(name: 'Telecommunications')
  #  Category.create(name: 'Television')
  #  Category.create(name: 'Transportation')
  #  Category.create(name: 'Travel')
  #  Category.create(name: 'Trucking')
  #  Category.create(name: 'Venture Capital')
  #  Category.create(name: 'Wholesale')
  #  Category.create(name: 'Writing')
end



#####OPTIONALS######



if !Career.exists?
  Career.create(title:'DCS Controls Design Commissioning Engineer',description:'

DCS Controls Design Commissioning Engineer - Field based
A global leader in the design and manufacture of Substation Intelligent Electronic Devices which deliver Protection, Measurement and Datacom functionality to our customers around the world.
We are currently looking for a Site Services Engineer to be responsible for the technical content of digital and/or conventional protection and control system projects.',link:'http://www.totaljobs.com/JobSearch/JobDetails.aspx?JobId=63225724&Keywords=&LTxt=&Radius=10')
  Career.create(title:'
French Business Development Executive, Software Sales ',description:'

French Speaking Business Development Executive

A global software company is currently looking for an energetic, enthusiastic, software-passionate Business Development Executive to join their busy London office, support them in their mission and contribute to their rapid growth! ',link:'http://www.totaljobs.com/JobSearch/JobDetails.aspx?JobId=63225723&Keywords=&LTxt=&Radius=10')
  Career.create(title:'Warehouse Operative / Distribution',description:'

No Experience Needed, Full training provided

**FULL DRIVING LICENSE ESSENTIAL**

Safestyle UK is rapidly expanding, and now is the best time to apply. With over 15 years experience in the industry, and an annual turnover of over £100 million, we have fast become the largest and most successful independent company producing uPVC doors and windows in the UK. ',link:'http://www.totaljobs.com/JobSearch/JobDetails.aspx?JobId=63225719&Keywords=&LTxt=&Radius=10')
  Career.create(title:'Accounts Payable Assistant',description:'
Position: Accounts Payable Assistant
A fantastic opportunity has arisen to join a £multi-million global bluechip organisation. Based at their Liverpool offices, you will be solely responsible for the day to day running of the Purchase Ledger.',link:'http://www.totaljobs.com/JobSearch/JobDetails.aspx?JobId=63225718&Keywords=&LTxt=&Radius=10')
  Career.create(title:'Branch Manager',description:'We are looking for the most talented and successful retail professionals and currently have an exciting opportunity for a Branch Manager to join our team. If you are ambitious, have great leadership skills and a passion for success then The Works is for you.',link:'http://www.totaljobs.com/JobSearch/JobDetails.aspx?JobId=63225706&Keywords=&LTxt=&Radius=10')
end


if !Faq.exists?

  Faq.create(faq_category_id:@cate_1.id, question:'Why should I register with SRAMIC?',
             answer:'SRAMIC helps you find the right job matching your aspirations. Registering with SRAMIC enables you to:

    1-  Access and apply in one-click to more than 1 lakh jobs
    2-  Store and access your Resume online
    3-  Get your CV viewed by over 35000 recuiters who will contact you with un-advertized jobs.
    4-  Create multiple customized profiles and apply to a job using the most relevant profile.')
  Faq.create(faq_category_id:@cate_1.id,question:'How can I post my Resume?',
             answer:'To post your Resume at SRAMIC.com, click on the ‘Post A Talent’ on www.SRAMIC.com. This takes you to the next step of filling up your personal and professional details. These details are important information that the recruiters look for. Once you’ve completed this, your profile registered with us. This is your default profile which is sent across to the recruiters when you apply for a particular job vacancy. We highly recommend you to fill all details so that you present recruiters a resume that is comprehensive and one that gets you the jobs you are looking for.')
  Faq.create(faq_category_id:@cate_2.id,question:'How will filling in a Jobseeker Profile help me?',
             answer:'When you complete a Jobseeker Profile, you are storing relevant information about you, in a format that a recruiter can search on using the tools we provide them. The profile is not compulsory, but it is recommended. Recruiters can search our database to find jobseekers (you) that best match the positions they have. This way, you stand a chance of being offered a job that suits your skills, without having to look for it. ')
  Faq.create(faq_category_id:@cate_3.id,question:'Why havent I had a response to my application?',
             answer:'When you apply for a job advertised on SRAMIC.com, you are effectively emailing the advertiser. SRAMIC.com does encourage our advertisers to respond to all applications, but unfortunately this does not always happen. It is always a good idea to follow up your application with an email or phone call. ')
  Faq.create(faq_category_id:@cate_4.id,question:'What are Job Postings? What all can I do with your Job Postings solution?',
             answer:'When you need to fill a position, time is money. And every minute counts. You need to get your job in front of the most qualified job seekers. You need an easy and reliable way to manage incoming CVs and select the right person for the job. And thats what posting your job on Sramic delivers - the most efficient and cost-effective way to hire online.')
  Faq.create(faq_category_id:@cate_5.id,question:'What is search?',answer:'Search gives you an option to look for relevant jobs based on your specific requirements. To search for a job, you can use the given search window. You may use the following criteria to look for relevant jobs.')
end


if !Testimonial.exists?
  Testimonial.create(name: 'Sharath', company: 'Sigma infosolutions',
                     description: "Recrutinig for these roles via SRAMIC has been fantastic.Loading a job advertisement through the website is quick and easy and allows the recruiter complete the control over the application process,with the ability to edit,repost or close adverts in just the click of a button
                    The  cv Database option has been a huge asset,giving us the option to search and directly approach candidates that meet our exact criteria.
                    Thanks to our account manager and SRAMIC we have successfully filled all of our postionsin a very short period of time.")
  Testimonial.create(name:'Joseph',company: 'IBM',description:"Recruiting internationally through SRAMIC is a very easy process.A dedicated account manager helps,from assisting with posting jobs in the correct areas to giving me feedback on candidate presence in the prospective areas.")
  Testimonial.create(name:'Demon',company:'Wipro',description:"We decided to trial SRAMIC to post our vacancies and put it to the test against our other methods.
    I am absolutely delighted with the results for the roles and locations;SRAMIC most certainly has a wide reach and proved successfull with some of our less specialist and central functional roles.")
  Testimonial.create(name:'Rajini',company:'Cognizant',description:"Our account manager has taken time to understand our business,and the different challenges that each member of my team faces in recruiting for their specialist areas.They listen and fully understand what we are looking for,allowing them to tailor and provide solutionsthat fully meet our needs. ")
end


##############################
#
#
# if !User.find_by(email: 'employer@gmail.com').present?
#   emp=User.create email:'employer@gmail.com', password:'Sigma@123',password_confirmation:'Sigma@123',role_id:2,confirmed_at:Date.today,name:'employer1'
# end
# if !User.find_by(email: 'employer2@gmail.com').present?
#   emp2=User.create email:'employer2@gmail.com', password:'Sigma@123',password_confirmation:'Sigma@123',role_id:2,confirmed_at:Date.today,name:'employer2'
# end
# if !User.find_by(email: 'jobseeker1@gmail.com').present?
#   jobseeker_user1=User.create email:'jobseeker1@gmail.com', password:'Sigma@123',password_confirmation:'Sigma@123',role_id:3,confirmed_at:Date.today,name:'jobseeker 1'
# end
# if !User.find_by(email: 'jobseeker2@gmail.com').present?
#   jobseeker_user2=User.create email:'jobseeker2@gmail.com', password:'Sigma@123',password_confirmation:'Sigma@123',role_id:3,confirmed_at:Date.today,name:'jobseeker 2'
# end
#
#
# employer1=Employer.first
# eprofile=employer1.eprofile
# employer2=Employer.last
# eprofile2=employer2.eprofile
#
# jobseeker1=Jobseeker.first
# jprofile_1=jobseeker1.jprofile
#
# jobseeker2=Jobseeker.last
# jprofile_2=jobseeker2.jprofile
#
#
# if !Education.exists?
#   Education.create(degree: 'MCA', institution: 'Bangalore Institude', location: 'bangalore', completion: 2011,jprofile_id: jprofile_2.id)
#   Education.create(degree: 'Bsc', institution: 'Bangalore Institude', location: 'bangalore', completion: 2011,jprofile_id: jprofile_2.id)
#   Education.create(degree: 'Bsc', institution: 'Bangalore Institude', location: 'bangalore', completion: 2011,jprofile_id: jprofile_1.id)
#   Education.create(degree: 'Btech', institution: 'Bangalore Institude', location: 'bangalore', completion: 2011,jprofile_id: jprofile_1.id)
#   Education.create(degree: 'Mtech', institution: 'Bangalore Institude', location: 'bangalore', completion: 2011,jprofile_id: jprofile_1.id)
# end
#
# if !Skill.exists?
#   Skill.create(year_of_experience: 1, name: 'java', jprofile_id: jprofile_1.id)
#   Skill.create(year_of_experience: 1, name: 'ror', jprofile_id: jprofile_1.id)
#   Skill.create(year_of_experience: 1, name: 'html', jprofile_id: jprofile_1.id)
#   Skill.create(year_of_experience: 1, name: 'html', jprofile_id: jprofile_2.id)
#   Skill.create(year_of_experience: 1, name: 'css', jprofile_id: jprofile_2.id)
#   Skill.create(year_of_experience: 1, name: 'jquery', jprofile_id: jprofile_2.id)
# end
#
#
# if !Job.exists?
#   job_1=Job.create title:'Associate Software Engineer',keywords:'software,Java',category_id:'1',employer_id:1,job_type_id:'1',industry_id:'5',description:'Software engineers apply the principles of software engineering to the design, development, maintenance, testing, and evaluation of the software and systems that make computers or anything containing software work.',country_list_id: '1',state_list_id: '1',city: 'Bangalore',zip: '56010'
#   job_2=Job.create title:'Java developer',keywords:'java,j2ee',employer_id:1,category_id:'1', job_type_id:'2',industry_id:'5',description:'Java is a set of several computer software and specifications developed by Sun Microsystems, later acquired by Oracle Corporation, that provides a system for developing application software and deploying it in a cross-platform computing environment. Java is used in a wide variety of computing platforms from embedded devices and mobile phones to enterprise servers and supercomputers. While less common, Java applets run in secure, sandboxed environments to provide many features of native applications and can be embedded in HTML pages.',country_list_id: '1',state_list_id: '2',city: 'Jaipur',zip: '33359'
#   job_3=Job.create title:'Senior Java/Grails professional', keywords:'java,grails',employer_id:1,job_type_id:'1',industry_id:'5',description:'Grails is an open source web application framework that uses the Groovy programming language (which is in turn based on the Java platform). It is intended to be a high-productivity framework by following the "coding by convention" paradigm, providing a stand-alone development environment and hiding much of the configuration detail from the developer.',country_list_id: '2',state_list_id: '2',city: 'Delhi',zip: '77524'
#   job_4=Job.create title:'Maths Teacher', keywords:'maths,basics', category_id:'4', employer_id:2,job_type_id:'2',industry_id:'1',description:'In contemporary education, mathematics education is the practice of teaching and learning mathematics, along with the associated scholarly research.Researchers in mathematics education are primarily concerned with the tools, methods and approaches that facilitate practice or the study of practice, however mathematics education research, known on the continent of Europe as the didactics or pedagogy of mathematics, has developed into an extensive field of study, with its own concepts, theories, methods, national and international organisations, conferences and literature. This article describes some of the history, influences and recent controversies.',country_list_id: '2',state_list_id: '2',city: 'Sultanpur',zip: '12010'
#   job_5=Job.create title:'Trainer', keywords:'software,basics', category_id:'3', employer_id:'2',job_type_id:'1',industry_id:'5',description:'Trainers work in many different areas, mainly educating employees of companies on specific topics of workplace importance. Some trainers are in-house, and others work for training companies.Trainers often work within the Human Resources department of a company, fulfilling the most frequent internal needs for education of the workers and management in a company.',country_list_id: '3',state_list_id: '3',city: 'Aurangabad',zip: '98445'
# end
#
#
#
# if !University.exists?
#   university1 = University.create(:name => 'university of calicut')
#   university2 = University.create(:name => 'university of toronto')
#   university3 = University.create(:name => 'university of california')
# end
#
# if !Discipline.exists?
#   discipline1 = Discipline.create(name: 'Arts')
#   discipline2 = Discipline.create(name: 'Science')
#   discipline3 = Discipline.create(name: 'Computer Science')
# end
#
# if !Grade.exists?
#   grade1 = Grade.create(name: 'Merit')
#   grade2 = Grade.create(name: 'Distinction')
#   grade3 = Grade.create(name: 'Pass')
# end
#
# if !Qualification.exists?
#   qualification1 = Qualification.create(name: 'Master ')
#   qualification2 = Qualification.create(name: 'Graduation ')
#   qualification3 = Qualification.create(name: 'Others')
# end
#
#
# if !Questionaire.exists?
#   Questionaire.create(question:"Waht is the Notice Period",answer:"2 Months",user_id: 3,eprofile_id:1)
#   Questionaire.create(question:"Which is the joining Location",answer:"Bangalore",user_id: 3,eprofile_id:1)
# end
# #if !Bookmark.exists?
# #Bookmark.create(title:"lorem epsum da ca eplods",eprofile_id:1)
# #end
# if !Share.exists?
#   Share.create(news:"Hiring freshers",eprofile_id:1)
# end
#
#
# if !SkillSet.exists?
#   SkillSet.create(name: 'Java')
#   SkillSet.create(name: '.net')
#   SkillSet.create(name: 'php')
#   SkillSet.create(name: 'RoR')
# end
#
#
#
# if !Salary.exists?
#   Salary.create(amount: '0-1000')
#   Salary.create(amount: '1001-10000')
#   Salary.create(amount: '10001-100000')
#   Salary.create(amount: '100001-100000')
#   Salary.create(amount: 'other')
# end
#
#
# if !CityList.exists?
#   CityList.create(name: 'Bangalore')
#   CityList.create(name: 'Hyd')
#   CityList.create(name: 'delhi')
# end
#
#
#
# if !EducationList.exists?
#   EducationList.create(name: 'Master Degree')
#   EducationList.create(name: "Bachelor Degree")
#   EducationList.create(name: 'Other')
# end
#
# if Subscription.first.nil?
#
#   @users = User.where.not(role_id: 1)
#   @users.each { |user|
#     if user.role.authority == 'jobseeker'
#       plan_id = 6
#     else
#       plan_id =1
#     end
#     #@plan = Plan.where(name: 'FREE', plan_type: user.role.authority).first
#     subscription = Subscription.create(plan_id: plan_id, user_id: user.id, start_date: Time.now)
#     PaymentInfo.create(subscription_id: subscription.id)
#
#   }
#
# end
