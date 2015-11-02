require 'rails_helper'

RSpec.describe "enquiries/index", type: :view do
  before(:each) do
    assign(:enquiries, [
      Enquiry.create!(),
      Enquiry.create!()
    ])
  end

  it "renders a list of enquiries" do
    render
  end
end
