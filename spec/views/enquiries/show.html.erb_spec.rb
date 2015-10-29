require 'rails_helper'

RSpec.describe "enquiries/show", type: :view do
  before(:each) do
    @enquiry = assign(:enquiry, Enquiry.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
