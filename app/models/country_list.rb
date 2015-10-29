class CountryList < ActiveRecord::Base
  has_many :state_lists
end
