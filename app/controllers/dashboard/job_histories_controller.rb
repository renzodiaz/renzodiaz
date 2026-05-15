class Dashboard::JobHistoriesController < Dashboard::AuthController
  before_action :set_job_history, only: [ :edit, :update, :destroy ]

  def index
    @job_histories = current_user.job_histories.order(end_date: :desc)
  end

  def new
    @job_history = current_user.job_histories.new
  end

  def create
    @job_history = current_user.job_histories.build(job_history_params)

    respond_to do |format|
      if @job_history.save
        format.turbo_stream { render turbo_stream: turbo_stream.update("drawer-frame", "") }
        format.html { redirect_to dashboard_job_histories_url, notice: "Job history created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("drawer-frame",
                                                   partial: "dashboard/job_histories/form",
                                                   locals: { job_history: @job_history }),
                 status: :unprocessable_entity
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job_history.update(job_history_params)
        format.turbo_stream { render turbo_stream: turbo_stream.update("drawer-frame", "") }
        format.html { redirect_to dashboard_job_histories_url, notice: "Job history updated successfully" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("drawer-frame",
                                                   partial: "dashboard/job_histories/form",
                                                   locals: { job_history: @job_history }),
                 status: :unprocessable_entity
        end
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @job_history.destroy
    respond_to do |format|
      format.turbo_stream { head :ok }
      format.html { redirect_to dashboard_job_histories_path, notice: "Job history deleted." }
    end
  end

  private

  def set_job_history
    @job_history = current_user.job_histories.find(params[:id])
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
