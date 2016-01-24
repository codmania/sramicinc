module AlertsHelper

    def self.job_alert

      job_alerts = JobAlert.all
      job_alerts.each { |job_alert|

        begin
            if !job_alert.where.nil?

              latlon = Geocoder.coordinates(job_alert.where)
              lat = latlon[0] if !latlon.nil?
              lon = latlon[1] if !latlon.nil?
            end
            pdate_start = Time.now
            pdate_end = pdate_start - 1.day

            @jobs_solr_search = Sunspot.search(Job) do
              fulltext job_alert.what.downcase.split(',').map { |x| x.downcase } if !job_alert.what.nil?
              with :created_at, pdate_end..pdate_start
              with(:status, true)
              with(:location_latlon).in_radius(lat, lon, job_alert.within) if !job_alert.where.nil? && !latlon.nil?
              order_by 'created_at', :desc
            end


            if @jobs_solr_search.try(:results).count > 0
              res = @jobs_solr_search.results
              AlertMailer.send_job_alert_email(job_alert.user.email, res).deliver_later
            end
        rescue => e
          puts '##########################'
          puts "Exception in Job alert:    #{e}"
          puts '##########################'
        end



      }


    end





    def self.talent_alert

      talent_alerts = TalentAlert.all
      talent_alerts.each { |talent_alert|

        begin
          if !talent_alert.where.nil?

            latlon = Geocoder.coordinates(talent_alert.where)
            lat = latlon[0] if !latlon.nil?
            lon = latlon[1] if !latlon.nil?
          end
          pdate_start = Time.now
          pdate_end = pdate_start - 1.day

          @jprofiles_solr_search = Sunspot.search(Jprofile) do
            fulltext talent_alert.what.downcase.split(',').map { |x| x.downcase } if !talent_alert.what.nil?
            with :created_at, pdate_end..pdate_start
            with(:location_latlon).in_radius(lat, lon, talent_alert.within) if !talent_alert.where.nil? && !latlon.nil?
            order_by 'created_at', :desc
          end


          if @jprofiles_solr_search.try(:results).count > 0
            res = @jprofiles_solr_search.results
            AlertMailer.send_talent_alert_email(talent_alert.user.email, res).deliver_later
          end
        rescue => e
          puts '##########################'
          puts "Exception in Alert alert:    #{e}"
          puts '##########################'
        end



      }


    end

    def self.job_status_change_alert
      @jobs_to_be_closed = Job.where(status: true).where("created_at < ?", 1.months.ago)
      @jobs_to_be_archived = Job.where(deleted: false).where("created_at < ?", 3.months.ago)
      begin
        @jobs_to_be_closed.update_all(status: false)
        @jobs_to_be_archived.update_all(deleted: true)
      rescue => ex
        puts '##########################'
        puts "Exception in Job Status Change Alert:    #{e}"
        puts '##########################'
      end
    end


    def self.subscription_checker

      Subscription.all.each {  |subscription|

        begin

            if subscription.plan_id != 1 && subscription.plan_id != 6 && subscription.end_date != nil?
              if subscription.end_date <= Time.now
                if subscription.user.role.authority == 'jobseeker'
                  plan_id = 6
                else
                  plan_id = 1
                end
                subscription.update_attributes(plan_id: plan_id, end_date: nil)
              end
            end

        rescue => e
          puts " subscription_checker Exception #{e}"
        end

      }

    end


end
