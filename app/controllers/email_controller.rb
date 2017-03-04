class EmailController < ApplicationController
	before_action :set_list_id, only: [:emails]
	before_action :set_email_list, only: [:editlist, :updatelist, :destroylist]
	protect_from_forgery with: :null_session

	def lists

		# appname = BluehelmetUtil.get_shopify_session_app_name
		@app    = App.where(name: ShopifyAPI::Shop.current.domain).first
		@list = EmailList.where(app_id: @app.id)

	end


	def editlist

	end

	def destroylist

	end

	# GET /newlist
	def newlist
	end

	# POST /create_list
	def create_list

		logger.debug 'We made it to create_list'

		app = App.where(name: ShopifyAPI::Shop.current.domain).first

		@email_list = EmailList.new(name: params[:name], description: params[:description], app_id: app.id)

		if @email_list.save
			@message = 'Email list was successfully created.'
		else
			@message = 'Email list was NOT created.'
		end

	end

	def emails

		# appname = BluehelmetUtil.get_shopify_session_app_name
		@app    = App.where(name: ShopifyAPI::Shop.current.domain).first
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

	# Use callbacks to share common setup or constraints between actions.
	def set_email_list
		@email_list = EmailList.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def email_list_params
		params.require(:email_list).permit(:name, :description, :app_id)
	end
end
