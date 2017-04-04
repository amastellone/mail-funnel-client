class MainInterfaceController < ShopifyApp::AuthenticatedController
  before_action :set_campaign_id, only: [:edit_campaign]

  def index
    app = BluehelmetUtil.get_app
    logger.info("App-Name: " + BluehelmetUtil.get_app_name)
    @campaigns = Campaign.where(app_id: app.id)
  end

  def job

    app = BluehelmetUtil.get_app

    @job = Job.find(params[:id])

  end

  def edit_campaign
    app = BluehelmetUtil.get_app
    @lists = EmailList.where(app_id: app.id)
    @hookslist = Hook.all
    @campaign = Campaign.find()
  end

  def create_campaign

    logger.debug 'We made it to create_campaign'

    app = BluehelmetUtil.get_app

    @campaign = Campaign.new(name: params[:name], hook: params[:hook_list_select], email_list_id: params[:email_list_select], app_id: app.id)

    if @campaign.save
      @message = 'Campaign was successfully created.'
    else
      @message = 'Campaign was NOT created.'
    end

  end

  def new_campaign
    app = BluehelmetUtil.get_app
    @lists = EmailList.where(app_id: app.id)
    @hookslist = Hook.all
    @campaign = Campaign.new
  end

  def campaign
    app = BluehelmetUtil.get_app #TODO: Get App name dynamically

    @campaign_id = params[:campaign_id]

    @campaign = Campaign.find(@campaign_id)

    @jobs = Job.where(campaign_id: @campaign_id)

    @lists = EmailList.where(app_id: app.id)
  end

  def campaigns
    @campaigns = Campaign.where(app_id: BluehelmetUtil.get_app_id)
  end

  def form_page
    if request.post?
      if params[:name].present?
        flash[:notice] = "Created #{ params[:colour] } unicorn: #{ params[:name] }."
      else
        flash[:error] = "Name must be set."
      end
    end
  end

  def pagination
    @total_pages = 3
    @page = (params[:page].presence || 1).to_i
    @previous_page = "/pagination?page=#{ @page - 1 }" if @page > 1
    @next_page = "/pagination?page=#{ @page + 1 }" if @page < @total_pages
  end

end
