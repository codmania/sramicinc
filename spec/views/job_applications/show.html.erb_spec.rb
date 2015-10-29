require 'rails_helper'

RSpec.describe "job_applications/show", type: :view do
  before(:each) do
    @job_application = assign(:job_application, JobApplication.create!(
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
