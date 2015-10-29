require 'rails_helper'

RSpec.describe "job_applications/index", type: :view do
  before(:each) do
    assign(:job_applications, [
      JobApplication.create!(
        :job_id => 1,
        :jobseeker_id => 2
      ),
      JobApplication.create!(
        :job_id => 1,
        :jobseeker_id => 2
      )
    ])
  end

  it "renders a list of job_applications" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
