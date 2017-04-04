class MailFunnelConfigsController < ShopifyApp::AuthenticatedController
  before_action :set_mail_funnel_config, only: [:show, :edit, :update, :destroy]

  # GET /mail_funnel_configs
  # GET /mail_funnel_configs.json
  def index
    @mail_funnel_configs = MailFunnelConfig.all
  end

  # GET /mail_funnel_configs/1
  # GET /mail_funnel_configs/1.json
  def show
  end

  # GET /mail_funnel_configs/new
  def new
    @mail_funnel_config = MailFunnelConfig.new
  end

  # GET /mail_funnel_configs/1/edit
  def edit
  end

  # POST /mail_funnel_configs
  # POST /mail_funnel_configs.json
  def create
    @mail_funnel_config = MailFunnelConfig.new(mail_funnel_config_params)

    respond_to do |format|
      if @mail_funnel_config.save
        format.html { redirect_to @mail_funnel_config, notice: 'Mail funnel config was successfully created.' }
        format.json { render :show, status: :created, location: @mail_funnel_config }
      else
        format.html { render :new }
        format.json { render json: @mail_funnel_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mail_funnel_configs/1
  # PATCH/PUT /mail_funnel_configs/1.json
  def update
    respond_to do |format|
      if @mail_funnel_config.update(mail_funnel_config_params)
        format.html { redirect_to @mail_funnel_config, notice: 'Mail funnel config was successfully updated.' }
        format.json { render :show, status: :ok, location: @mail_funnel_config }
      else
        format.html { render :edit }
        format.json { render json: @mail_funnel_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mail_funnel_configs/1
  # DELETE /mail_funnel_configs/1.json
  def destroy
    @mail_funnel_config.destroy
    respond_to do |format|
      format.html { redirect_to mail_funnel_configs_url, notice: 'Mail funnel config was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mail_funnel_config
      @mail_funnel_config = MailFunnelConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mail_funnel_config_params
      params.require(:mail_funnel_config).permit(:name, :value)
    end
end
