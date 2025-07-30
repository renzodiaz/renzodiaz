class HomeController < ApplicationController
  def index
    @job_histories = JobHistory.order(start_date: :asc)
  end
end
