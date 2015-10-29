require 'rails_helper'

RSpec.describe "watch_lists/edit", type: :view do
  before(:each) do
    @watch_list = assign(:watch_list, WatchList.create!(
      :job_id => 1,
      :jobseeker_id => 1
    ))
  end

  it "renders the edit watch_list form" do
    render

    assert_select "form[action=?][method=?]", watch_list_path(@watch_list), "post" do

      assert_select "input#watch_list_job_id[name=?]", "watch_list[job_id]"

      assert_select "input#watch_list_jobseeker_id[name=?]", "watch_list[jobseeker_id]"
    end
  end
end
