require 'rails_helper'

RSpec.describe Job, type: :model do
  it "Views all Jobs" do
    p "Testing App Index"
    jobs = Job.all

    p jobs
    expect(app.id).to be > -1
  end

  # it "Creates a job" do
  #   p "Testing Create Job"
  #
  #   Job.create(name: "test-job-name-1")
  #
  #   result = App.where(name: "test-job-name-1")
  #   expect(result.id).to be > -1
  # end
end
