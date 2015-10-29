class PageController < ApplicationController
  skip_filter  :authenticate_user!

  def about
  end


  def home_page_banner

  end
end
