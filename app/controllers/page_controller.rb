class PageController < ApplicationController
  skip_filter  :authenticate_user!

  def about
  end

  def pricing
    @employer_plans = Plan.where(plan_type: 'Employer').order(:days);
    @jobseeker_plans = Plan.where(plan_type: 'Jobseeker').order(:days);
  end

  def terms
  end

  def privacy
  end

  def home_page_banner

  end
end
