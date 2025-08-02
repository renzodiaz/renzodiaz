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

    respond_to do |format|
      if @job_history.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("job_history_list",
                                partial: "dashboard/job_histories/job_history",
                                locals: { job_history: @job_history })
          ]
        end
        format.html { redirect_to dashboard_job_histories_url, notice: "Job history created successfully" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("drawer-frame",
                                                   partial: "dashboard/job_histories/form",
                                                   locals: { job_history: @job_history })
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @job_history.update(job_history_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("job_history_list",
                                                   partial: "dashboard/job_histories/job_history",
                                                   locals: { job_history: @job_history })
        end
        format.html { redirect_to dashboard_job_histories_url, notice: "Job history updated successfully"  }
      end
    else
      render partial: "dashboard/job_histories/form", status: :unprocessable_entity, locals: { job_history: @job_history  }
    end
  end

  def destroy
    if @job_history.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@job_history) }
        format.html { redirect_to dashboard_job_histories_path, notice: "Job history deleted."  }
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
