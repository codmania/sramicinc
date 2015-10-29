require 'rails_helper'

RSpec.describe "carts/index", type: :view do
  before(:each) do
    assign(:carts, [
      Cart.create!(
        :job_id => 1,
        :jobseeker_id => 2
      ),
      Cart.create!(
        :job_id => 1,
        :jobseeker_id => 2
      )
    ])
  end

  it "renders a list of carts" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
