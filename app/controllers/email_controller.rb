class EmailController < ApplicationController

	before_action :set_list_id, only: [:emails]

	def list
		# appname = BluehelmetUtil.get_shopify_session_app_name
		@app    = App.where(name: "bluehelmet-dev").first
		@list = EmailList.where(app_id: @app.id)
	end

	def newlist

	end

	def editlist

	end

	def deletelist

	end

	def emails
		# appname = BluehelmetUtil.get_shopify_session_app_name
		@app    = App.where(name: "bluehelmet-dev").first
		@emails = Email.where(email_list_id: @list.id)
	end

	def newemail

	end

	def editemail

	end

	def deleteemail

	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_list_id
			@list = EmailList.find(params[:list_id])
		end
end
