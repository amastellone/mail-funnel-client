class MainInterfaceController < ShopifyApp::AuthenticatedController

  def index
    app = App.where(name: ShopifyAPI::Shop.current.domain).first
    @campaigns = Campaign.where(app_id: app.id)
  end

  def job

    app = App.where(name: ShopifyAPI::Shop.current.domain).first

    @job = Job.find(params[:id])

  end

  def create_campaign

    logger.debug 'We made it to create_campaign'

    app = App.where(name: ShopifyAPI::Shop.current.domain).first # TODO: Get this app name dynamically


    @campaign = Campaign.new(name: params[:name], hook: params[:hook_list_select], email_list_id: params[:email_list_select], app_id: app.id)

    if @campaign.save
      @message = 'Campaign was successfully created.'
    else
      @message = 'Campaign was NOT created.'
    end

  end

  def new_campaign
    app = App.where(name: ShopifyAPI::Shop.current.domain).first #TODO: Change this to dynamic app name
    @lists = EmailList.where(app_id: app.id)
    @hookslist = Hook.all
  end

  def campaign
    app = App.where(name: ShopifyAPI::Shop.current.domain).first #TODO: Get App name dynamically

    @campaign_id = params[:campaign_id]

    @campaign = Campaign.find(@campaign_id)

    @jobs = Job.where(campaign_id: @campaign_id)

    @lists = EmailList.where(app_id: app.id)
  end

  def campaigns
    app = App.where(name: ShopifyAPI::Shop.current.domain).first # TODO: Make this load the app dynamically

    @campaigns = Campaign.where(app_id: app.id)
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
