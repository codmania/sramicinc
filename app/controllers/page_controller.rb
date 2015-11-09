class PageController < ApplicationController
  skip_filter  :authenticate_user!

  def about
  end

  def pricing
  end

  def terms
  end

  def privacy
  end

  def home_page_banner

  end
end
