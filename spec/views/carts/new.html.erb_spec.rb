require 'rails_helper'

RSpec.describe "carts/new", type: :view do
  before(:each) do
    assign(:cart, Cart.new(
      :job_id => 1,
      :jobseeker_id => 1
    ))
  end

  it "renders new cart form" do
    render

    assert_select "form[action=?][method=?]", carts_path, "post" do

      assert_select "input#cart_job_id[name=?]", "cart[job_id]"

      assert_select "input#cart_jobseeker_id[name=?]", "cart[jobseeker_id]"
    end
  end
end
