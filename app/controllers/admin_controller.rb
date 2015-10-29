class AdminController < ApplicationController
  def index
  end
  
  def cms
    puts '>>>> '+params.inspect()    
    @page=Page.find(params[:id]) if params[:id]    
    if request.patch?
      @page.content=params[:page][:content]
      @page.save

      redirect_to admin_cms_pages_path
    end
  end

  def cms_pages

    @pages = Page.all
  end
end
