class NewsLetter < ActiveRecord::Base

  def news_letter_status
    if self.active?
      'active'
    else
      'deactivate'
    end
  end
end
