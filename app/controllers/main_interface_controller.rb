class MainInterfaceControllerf < ShopifyApp::AuthenticatedController

  def index
    app = App.where(name: "bluehelmet-dev").first
    @campaigns = Campaign.where(app_id: app.id)
  end

  def campaign
    app = App.where(name: "bluehelmet-dev").first

    campaign_id = params[:campaign_id]

    @jobs = Job.where(campaign_id: campaign_id)

    @lists = EmailList.where(app_id: app.id)
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
