class SearchController < ApplicationController
  skip_before_filter :authenticate_user!

  def search_jobs

    if params['where'].nil? && params[:what].nil? && params[:distance].nil?
      @res = nil
    else
      location_searchable = false
      if params['distance'].present?
        location_searchable = true
      end
      if params['where'].present?
        latlon = Geocoder.coordinates(params[:where])
        # latlon = [12.8845097, 77.6035522]
        lat = latlon[0] if !latlon.nil?
        lon = latlon[1] if !latlon.nil?
      else
        if params['latitude'].present?
          lat = params[:latitude]
          lon = params[:longitude]
        else
          location_searchable = false
        end
      end
      pdate_start = Time.now
      pdate_end = pdate_start - 1.day
      bod = Time.now.beginning_of_day.to_time
      if params[:postingdate].present?
        pdate_end=pdate_start-1.day if params[:postingdate]=='Last 24 hours'
        pdate_end=pdate_start-3.days if params[:postingdate]=='Last 3 days'
        pdate_end=pdate_start-7.days if params[:postingdate]=='Last 7 days'
        pdate_end=pdate_start-15.days if params[:postingdate]=='Last 15 days'
        pdate_end=pdate_start-30.days if params[:postingdate]=='Last 30 days'
      end
      params[:page] = 1 unless params[:page].present?
      params[:sort] = 'score' unless params[:sort].present?
      params[:sort] = 'score' if params[:sort] == 'relevance'
      params[:sort] = 'created_at' if params[:sort] == 'date'
      params[:per_page]=params[:offset].nil? ? PER_PAGE_COUNT : params[:offset]
      @res = Sunspot.search(Job) do
        fulltext params[:what].downcase.split(',').map { |x| x.downcase } if params[:what].present?
        fulltext params[:title].downcase.split(',').map { |x| x.downcase }, :fields => :title if params[:title].present?
        keyword = params[:keywords].split(/[,\s]+/).map(&:strip).map { |x| x.downcase } if params[:keywords].present?
        with(:plain_description).any_of(keyword) if params[:keywords].present?
        #with(:keywords).any_of(keyword) if params[:keywords].present?
        #fulltext params[:keywords].split(',').map{|x| x.downcase}, :fields=>:keywords if params[:keywords].present?
        #with(:keywords, params[:keywords].downcase do minimum_match 1 end )  if params['keywords'].present?
        #with(:keywords, params[:keywords].downcase.split(',').map{|x| x.downcase}) if params['keywords'].present?
        #with(:title,params[:title].downcase) do minimum_match 10 end   if params['title'].present?
        #with(:companyname, params[:company].downcase) if params['company'].present?
        fulltext params[:company].downcase.split(',').map { |x| x.downcase }, :fields => :companyname if params[:company].present?
        with :created_at, pdate_end..pdate_start if params[:postingdate].present?
        with(:job_type, params[:job_type].downcase) if params['job_type'].present?
        with(:salary_type, params[:salary_type].downcase) if params['salary_type'].present?
        with(:salary, params[:salary].downcase) if params['salary'].present?
        with(:industry, params[:industry].downcase) if params['industry'].present?
        #with(:city, params[:city].downcase) if params['city'].present?
        with(:city, params[:city].split.map(&:capitalize).join(' ')) if params['city'].present?
        with(:state, params[:state].downcase) if params['state'].present?
        with(:status, true)
        with(:job_searchable, true)
        with(:publicviewing, true) if current_user.nil?
        with(:deleted, false)
        with(:location_latlon).in_radius(lat, lon, params[:distance]) if location_searchable #if params[:where].present? && !latlon.nil?
        order_by params[:sort], :desc
        with(:salary_type, params[:salary_type].downcase) if params['salary_type'].present?
        paginate(page: params[:page], per_page: params[:per_page])

        # loc_filter= with(:location_latlon).in_radius(lat, lon, params[:distance])
        # if params['where'].present? && !latlon.nil?
        facet(:distance_facet) do
          row('1') do
            with(:location_latlon).in_radius(lat, lon, 1)
          end
          row('5') do
            with(:location_latlon).in_radius(lat, lon, 5)
          end
          row('10') do
            with(:location_latlon).in_radius(lat, lon, 10)
          end
          row('15') do
            with(:location_latlon).in_radius(lat, lon, 15)
          end
          row('20') do
            with(:location_latlon).in_radius(lat, lon, 20)
          end
          row('50') do
            with(:location_latlon).in_radius(lat, lon, 50)
          end
          row('100') do
            with(:location_latlon).in_radius(lat, lon, 100)
          end
          row('500') do
            with(:location_latlon).in_radius(lat, lon, 500)
          end
          row('1000') do
            with(:location_latlon).in_radius(lat, lon, 1000)
          end
          row('5000') do
            with(:location_latlon).in_radius(lat, lon, 5000)
          end
          row('10000') do
            with(:location_latlon).in_radius(lat, lon, 10000)
          end
          row('50000') do
            with(:location_latlon).in_radius(lat, lon, 50000)
          end
        end
        # end
        facet :job_age do
          bod = Time.now
          row :'Last 24 hours' do
            with :created_at, (bod - 1.day)..bod
          end
          row :'Last 3 days' do
            with :created_at, (bod - 3.days)..bod
          end
          row :'Last 7 days' do
            with :created_at, (bod - 7.days)..bod
          end
          row :'Last 15 days' do
            with :created_at, (bod - 15.days)..bod
          end
          row :'Last 30 days' do
            with :created_at, (bod - 30.days)..bod
          end
        end
        facet :companyname, :job_type, :industry, :state, :city
      end

    end


    if current_user.nil?
      @saved_searched_filer = []
    else
      @saved_searched_filer = SearchFilter.where(user_id: current_user.id)
    end

    if params[:offset]=='1'
      str=''
      params.each do |key, value|
        if key!="page" && key!="action" && key!="controller"
          str+=key.to_s+'='+value+'&'
        end
      end
      str+='page='+params[:page]
      str+='&total='+(@res.try(:total).to_s)
      if @res.try(:results)[0]!=nil
        redirect_to job_path(id: @res.try(:results)[0].id).to_s+'/?'+str #(id:1,params:p)
      end
    end

  end


  def search_profiles
    # if current_user.try(:role).try(:authority) == 'jobseeker'
    #   respond_to do |format|
    #     format.html { redirect_to home_index_url, alert: 'You are not authendicated person to enter this.' }
    #     format.json { head :no_content }
    #   end
    # end

    #puts "****** #{params}"
    if params['where'].nil? && params[:what].nil? && params[:distance].nil?
      @res = nil

    else
      location_searchable = false
      if params['distance'].present?
        location_searchable = true
      end
      if params['where'].present?
        latlon = Geocoder.coordinates(params[:where])
        # latlon = [12.8845097, 77.6035522]
        lat = latlon[0] if !latlon.nil?
        lon = latlon[1] if !latlon.nil?
      else
        if params['latitude'].present?
          lat = params[:latitude]
          lon = params[:longitude]
        else
          location_searchable = false
        end
      end
      puts 'latlo ' + latlon.to_s

      pdate_start = Time.now
      pdate_end = pdate_start - 1.day
      # with :created_at, bod..(bod - 1)
      bod = Time.now.beginning_of_day.to_time
      if params[:postingdate].present?
        pdate_end=pdate_start-1.day if params[:postingdate]=='Last 24 hours'
        pdate_end=pdate_start-3.days if params[:postingdate]=='Last 3 days'
        pdate_end=pdate_start-7.days if params[:postingdate]=='Last 7 days'
        pdate_end=pdate_start-15.days if params[:postingdate]=='Last 15 days'
        pdate_end=pdate_start-30.days if params[:postingdate]=='Last 30 days'
      end
      params[:page] = 1 unless params[:page].present?
      params[:sort] = 'score' unless params[:sort].present?
      params[:sort] = 'score' if params[:sort] == 'relevance'
      params[:sort] = 'created_at' if params[:sort] == 'date'
      params[:per_page]=params[:offset].nil? ? PER_PAGE_COUNT : params[:offset]

      # @res = Sunspot.search(Jprofile) do
      @res =  Sunspot.search(Jprofile) do
        fulltext params[:what].downcase if params[:what].present?
        fulltext params[:title].downcase.split(',').map { |x| x.downcase }, :fields => :title if params[:title].present?
        #with(:title, params[:title].downcase) if params['title'].present?
        # skills = params[:skills].split(/[,\s]+/).map(&:strip).map { |x| x.downcase } if params[:skills].present?
        # with(:skills).any_of(skills) if params[:skills].present?
        fulltext params[:skills].downcase.split(',').map { |x| x.downcase }, :fields => :skills if params[:skills].present?
       # with(:skills, params[:skills].downcase) if params['skills'].present?
        with(:educations, params[:education].downcase) if params['education'].present?
        with(:salary_type, params[:salary_type].downcase) if params['salary_type'].present?
        with(:salary, params[:salary].downcase) if params['salary'].present?
        with :created_at, pdate_end..pdate_start if params[:postingdate].present?
        with(:industry, params[:industry].downcase) if params['industry'].present?
        #with(:city, params[:city].downcase) if params['city'].present?
        with(:city, params[:city].split.map(&:capitalize).join(' ')) if params['city'].present?
        with(:state, params[:state].downcase) if params['state'].present?
        with(:location_latlon).in_radius(lat, lon, params[:distance]) if location_searchable and !lat.nil? #if params['where'].present? && !latlon.nil?
        with(:user_active, true)
        with(:profile_searchable, true)
        without(:user_confirmed_at, nil)
        with(:publicviewing, true) if current_user.nil?
        order_by params[:sort], :desc
        paginate(page: params[:page], per_page: params[:per_page])
        #loc_filter= with(:location_latlon).in_radius(lat, lon, params[:distance])

        # if params['where'].present? && !latlon.nil?
        facet(:distance_facet) do
          row('1') do
            with(:location_latlon).in_radius(lat, lon, 1) if not lat.nil?
          end
          row('5') do
            with(:location_latlon).in_radius(lat, lon, 5) if not lat.nil?
          end
          row('10') do
            with(:location_latlon).in_radius(lat, lon, 10) if not lat.nil?
          end
          row('15') do
            with(:location_latlon).in_radius(lat, lon, 15) if not lat.nil?
          end
          row('20') do
            with(:location_latlon).in_radius(lat, lon, 20) if not lat.nil?
          end
          row('50') do
            with(:location_latlon).in_radius(lat, lon, 50) if not lat.nil?
          end
          row('100') do
            with(:location_latlon).in_radius(lat, lon, 100) if not lat.nil?
          end
          row('500') do
            with(:location_latlon).in_radius(lat, lon, 500) if not lat.nil?
          end
          row('1000') do
            with(:location_latlon).in_radius(lat, lon, 1000) if not lat.nil?
          end
          # row('5000') do
          #   with(:location_latlon).in_radius(lat, lon, 5000) if not lat.nil?
          # end
          # row('10000') do
          #   with(:location_latlon).in_radius(lat, lon, 10000) if not lat.nil?
          # end
          # row('50000') do
          #   with(:location_latlon).in_radius(lat, lon, 50000) if not lat.nil?
          # end
        end
        # end
        facet :jprofile_age do
          bod = Time.now
          row :'Last 24 hours' do
            with :created_at, (bod - 1.day)..bod
          end
          row :'Last 3 days' do
            with :created_at, (bod - 3.days)..bod
          end
          row :'Last 7 days' do
            with :created_at, (bod - 7.days)..bod
          end
          row :'Last 15 days' do
            with :created_at, (bod - 15.days)..bod
          end
          row :'Last 30 days' do
            with :created_at, (bod - 30.days)..bod
          end
        end
        #facet :companyname, :categoryname, :industry, :state, :city
        facet :state, :city

      end
    end


    if current_user.nil?
      @saved_searched_filer = []
    else
      @saved_searched_filer = SearchFilter.where(user_id: current_user.id)
    end

    if params[:offset]=='1'
      str=''
      params.each do |key, value|
        if key!="page" && key!="action" && key!="controller" && key!="id"
          str+=key.to_s+'='+value+'&'
        end
      end

      str+='page='+params[:page]
      str+='&total='+(@res.try(:total).to_s)

      if @res.try(:results)[0]!=nil
        redirect_to employer_talents_path(id: @res.try(:results)[0].id).to_s+'&'+str #(id:1,params:p)
      end
    end


  end


  def search_local_employers
    #@jobs = Job.near([params['latitude'], params['longitude']],100).where('status = ?', 'close').group("employer_id").limit(4)

    @jobs = Job.near([params['latitude'], params['longitude']], 100).group("employer_id").limit(4)

    render :partial => 'local_employer_right_bar'
  end


  def search_local_talents
    #@jobs = Job.near([params['latitude'], params['longitude']],100).where('status = ?', 'close').group("employer_id").limit(4)

    @jprofiles = Jprofile.near([params['latitude'], params['longitude']], 100).order('updated_at desc').limit(4)


    render :partial => 'local_talent_right_bar'
  end


  def save_search_criteria

    if !SearchFilter.where(name: params['filter_name'], user_id: current_user.id).first.nil?
      @searchFilter = SearchFilter.where(name: params['filter_name'], user_id: current_user.id).first
      @searchFilter.update_attributes(criteria: params['search_string'])
    else
      SearchFilter.create(name: params['filter_name'], criteria: params['search_string'], user_id: current_user.id)
    end

    @saved_searched_filer = SearchFilter.where(user_id: current_user.id)
    if current_user.try(:role).try(:authority) =='jobseeker'
      render :partial => 'saved_job_search_filer'
    elsif current_user.try(:role).try(:authority) =='employer'
      render :partial => 'saved_talent_search_filer'
    end

  end

  def delete_search_criteria

    @searchFilter = SearchFilter.find(params['filter_id'])
    if !@searchFilter.nil?
      @searchFilter.destroy
    end

    @saved_searched_filer = SearchFilter.where(user_id: current_user.id)

    if current_user.try(:role).try(:authority) =='jobseeker'
      render :partial => 'saved_talent_search_filer'
    elsif current_user.try(:role).try(:authority) =='employer'
      render :partial => 'saved_job_search_filer'
    end


  end


end
