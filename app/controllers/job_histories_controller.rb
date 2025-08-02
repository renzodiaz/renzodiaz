class JobHistoriesController < ApplicationController
  before_action :set_job_history, only: [ :show ]

  def show
    render partial: "job_histories/modal_content", layout: false
  end

  private

  def set_job_history
    @job_history = JobHistory.find(params[:id])
  end
end
