class FaqCategory < ActiveRecord::Base
	has_many :faqs
end
