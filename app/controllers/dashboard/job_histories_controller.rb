class Dashboard::JobHistoriesController < Dashboard::AuthController
  before_action :set_job_history, only: [ :edit, :create, :update, :destroy ]

  def index
    @job_histories = JobHistory.order(end_date: :desc)
  end

  def new
    @job_history = JobHistory.new
  end

  def create
    @job_history.user = current_user
    if @job_history.save
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    else
      render partial: "dashboard/job_histories/form", status: :unprocessable_entity, locals: { job_history: @job_history }
    end
  end

  def update
    if @job_history.update(job_history_params)
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    else
      render partial: "dashboard/job_histories/form", status: :unprocessable_entity, locals: { job_history: @job_history  }
    end
  end

  def destroy
    if @job_history.destroy
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end
  end

  private

  def set_job_history
    @job_history = params[:id].present? ? JobHistory.find(params[:id]) : JobHistory.new(job_history_params)
  end


  def job_history_params
    params.require(:job_history).permit(
      :cover,
      :company_name,
      :website_url,
      :job_title,
      :description,
      :start_date,
      :end_date,
      :location,
      :is_current
    )
  end
end
