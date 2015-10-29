require 'rails_helper'

RSpec.describe "carts/show", type: :view do
  before(:each) do
    @cart = assign(:cart, Cart.create!(
      :job_id => 1,
      :jobseeker_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
