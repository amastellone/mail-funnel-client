require 'htmlentities'
require 'JobLocal'

# TODO: Funnel-Builer: Account for empty data here

class FunnelBuilderController < ApplicationController

	def api_index

		width       = params[:width]

		# Either one
		hook        = params[:hook_id]
		campaign_id = params[:campaign_id] # Not used yet

		app_param = params[:app_id]
		app       = App.find(app_param)
		appid     = app.id

		@email_lists = EmailList.where(app_id: appid)

		@local_jobs = Array.new

		top           = 0
		top_increment = 150 #Top Increment

		count     = 0
		operators = Hash.new

		# TODO: Convert all Hash Keys to :key format and change from " to ' single quotes

		Campaign.where(hooks_constant_id: hook).each do |campaign|

			operator_title = ("campaign_" + count.to_s).to_s

			operators[operator_title] =
				 {
						"top"                  => top.to_s,
						"left"                 => "80",
						"multipleLinksOnInput" => "true",
						"properties"           => {
							 "title"   => "Campaign",
							 "inputs"  => {},
							 "outputs" => {
									"output_1" => {
										 "label" => campaign.name + " Jobs:",
									}
							 }
						}
				 }
			top                       = top + top_increment
			count                     += 1
		end

		top             = 175
		left_increment  = 160
		right_increment = 160
		@left_decrement = right_increment

		# TODO: Choose funnel builder column_count from document width
		column_count    = 5

		count = 0
		Campaign.where(hooks_constant_id: hook).each do |campaign|

			left  = 0
			right = 0
			Job.where(app_id: appid, client_campaign: campaign.id).each do |j|
				if count % column_count == 0 && count != 0
					left  = 0
					right = 0
					top   = top + top_increment
				end
				p 'Adding Job ID ' + appid.to_s

				jl                  = JobLocal.new
				jl.local_identifier = 'job_' + j.id.to_s
				jl.hook_identifier  = campaign.hook_identifier
				jl.subject          = j.subject
				jl.content          = j.content
				jl.email_list_id    = j.email_list_id
				jl.app_id           = j.app_id
				jl.name             = j.name
				jl.client_campaign  = j.client_campaign
				@local_jobs << jl

				operator_title            = (jl.local_identifier).to_s
				operators[operator_title] =
					 {
							"top"                  => top.to_s,
							"left"                 => left.to_s,
							"multipleLinksOnInput" => "false",
							"properties"           => {
								 "title"   => "Email Job",
								 "inputs"  => {
										"input_1" => {
											 "label" => j.name
										}
								 },
								 "outputs" => {
										"output_1" => {
											 "label" => "Next Job:",
										}
								 }
							}
					 }
				left                      = left + left_increment
				right                     = right + right_increment
				count                     += 1
			end
			top = top + top_increment
		end


		connections    = Hash.new
		link_count     = 0
		campaign_count = 0
		last_job_id    = 0
		Campaign.where(hooks_constant_id: hook).each do |campaign|
			firstjob = true
			Job.where(app_id: appid, client_campaign: campaign.id).each do |j|
				connector_title = ("link_" + link_count.to_s).to_s
				if firstjob
					connections[connector_title] =
						 {
								"fromOperator"  => "campaign_" + campaign_count.to_s,
								"fromConnector" => "output_1",
								"toOperator"    => "job_" + j.id.to_s,
								"toConnector"   => "input_1"
						 }
					campaign_count               += 1
					firstjob                     = false
				else
					connections[connector_title] =
						 {
								"fromOperator"  => "job_" + last_job_id.to_s,
								"fromConnector" => "output_1",
								"toOperator"    => "job_" + j.id.to_s,
								"toConnector"   => "input_1"
						 }
				end
				last_job_id = j.id
				link_count  += 1
			end
		end

		data = {
			 "operators" => operators,
			 "links"     => connections
		}

		final_json = JSON.pretty_generate({
			                               "data" => data
		                              })

		logger.debug "Funnel-Builder INDEX JSON: " + final_json.to_s

		render json: final_json

	end

	def index
		# Build this information as JSON

		app = App.where(name: 'bluehelmet-dev').first
		@app_id = app.id

		@email_lists = EmailList.where(app_id: app.id)

		hook_id_new = params[:hook_id]
		hook = HooksConstant.all.second
		@hook_id = hook.id

		@local_jobs = Array.new
		Campaign.where(hooks_constant_id: hook.id).each do |campaign|

			@campaign_id = campaign.id

			Job.where(app_id: app.id, client_campaign: campaign.id).each do |j|
				p 'Adding Job ID ' + j.id.to_s

				jl                  = JobLocal.new
				jl.local_identifier = 'job_' + j.id.to_s
				jl.hook_identifier  = campaign.hook_identifier
				jl.subject          = j.subject
				jl.content          = j.content
				jl.email_list_id    = j.email_list_id
				jl.app_id           = j.app_id
				jl.name             = j.name
				jl.client_campaign  = j.client_campaign
				@local_jobs << jl

			end
		end

	end

	def api_update
	end
	def api_view
	end
	def api_create
	end
	def api_delete
	end


end
