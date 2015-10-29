require 'rails_helper'

RSpec.describe "watch_lists/show", type: :view do
  before(:each) do
    @watch_list = assign(:watch_list, WatchList.create!(
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
