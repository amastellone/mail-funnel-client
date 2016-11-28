class EmailsController < ApplicationController

	before_action :set_list_id, only: [:lists]

	def lists
		# @lists = EmailsList.where()

		# grape = Her::API.new
		# grape.setup url: "https://other-api.example.com" do |c|
		# 	# Response
		# 	c.use Her::Middleware::DefaultParseJSON
		#
		# 	# Adapter
		# 	c.use Faraday::Adapter::NetHttp
		# end

		app    = App.where(name: "bluehelmet-dev").first
		@lists = EmailsList.where(app_id: app.id)


	end

	def newlist

	end

	def editlist

	end

	def deletelist

	end

	def emails
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
			@list = EmailsList.find(params[:id])
		end
end
