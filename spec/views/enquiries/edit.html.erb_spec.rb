require 'rails_helper'

RSpec.describe "enquiries/edit", type: :view do
  before(:each) do
    @enquiry = assign(:enquiry, Enquiry.create!())
  end

  it "renders the edit enquiry form" do
    render

    assert_select "form[action=?][method=?]", enquiry_path(@enquiry), "post" do
    end
  end
end
