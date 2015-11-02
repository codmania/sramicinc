require 'rails_helper'

RSpec.describe "watch_lists/new", type: :view do
  before(:each) do
    assign(:watch_list, WatchList.new(
      :job_id => 1,
      :jobseeker_id => 1
    ))
  end

  it "renders new watch_list form" do
    render

    assert_select "form[action=?][method=?]", watch_lists_path, "post" do

      assert_select "input#watch_list_job_id[name=?]", "watch_list[job_id]"

      assert_select "input#watch_list_jobseeker_id[name=?]", "watch_list[jobseeker_id]"
    end
  end
end
