class JobsLocalController < ApplicationController

	def view
		app = App.where(name: "bluehelmet-dev").first
		campaign_id = params[:id]
		@jobs = Job.where(app_id: app.id, client_campaign: campaign_id)
		@campaign = Campaign.find(campaign_id)
	end

end
