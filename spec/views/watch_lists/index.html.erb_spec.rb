require 'rails_helper'

RSpec.describe "watch_lists/index", type: :view do
  before(:each) do
    assign(:watch_lists, [
      WatchList.create!(
        :job_id => 1,
        :jobseeker_id => 2
      ),
      WatchList.create!(
        :job_id => 1,
        :jobseeker_id => 2
      )
    ])
  end

  it "renders a list of watch_lists" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
