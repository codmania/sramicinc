require 'rails_helper'

RSpec.describe "carts/edit", type: :view do
  before(:each) do
    @cart = assign(:cart, Cart.create!(
      :job_id => 1,
      :jobseeker_id => 1
    ))
  end

  it "renders the edit cart form" do
    render

    assert_select "form[action=?][method=?]", cart_path(@cart), "post" do

      assert_select "input#cart_job_id[name=?]", "cart[job_id]"

      assert_select "input#cart_jobseeker_id[name=?]", "cart[jobseeker_id]"
    end
  end
end
