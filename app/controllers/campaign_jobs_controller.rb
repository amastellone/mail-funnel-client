class CampaignJobsController < ApplicationController
  before_action :set_campaign_job, only: [:show, :edit, :update, :destroy]

  # GET /campaign_jobs
  # GET /campaign_jobs.json
  def index
    @campaign_jobs = CampaignJob.all
  end

  # GET /campaign_jobs/1
  # GET /campaign_jobs/1.json
  def show
  end

  # GET /campaign_jobs/new
  def new
    @campaign_job = CampaignJob.new
  end

  # GET /campaign_jobs/1/edit
  def edit
  end

  # POST /campaign_jobs
  # POST /campaign_jobs.json
  def create
    @campaign_job = CampaignJob.new(campaign_job_params)

    respond_to do |format|
      if @campaign_job.save
        format.html { redirect_to @campaign_job, notice: 'Campaign job was successfully created.' }
        format.json { render :show, status: :created, location: @campaign_job }
      else
        format.html { render :new }
        format.json { render json: @campaign_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaign_jobs/1
  # PATCH/PUT /campaign_jobs/1.json
  def update
    respond_to do |format|
      if @campaign_job.update(campaign_job_params)
        format.html { redirect_to @campaign_job, notice: 'Campaign job was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign_job }
      else
        format.html { render :edit }
        format.json { render json: @campaign_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaign_jobs/1
  # DELETE /campaign_jobs/1.json
  def destroy
    @campaign_job.destroy
    respond_to do |format|
      format.html { redirect_to campaign_jobs_url, notice: 'Campaign job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign_job
      @campaign_job = CampaignJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_job_params
      params.require(:campaign_job).permit(:campaign_id_id, :job_uuid_id, :position)
    end
end
