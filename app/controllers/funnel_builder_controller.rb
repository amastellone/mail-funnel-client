require 'htmlentities'
require 'JobLocal'

# TODO: Funnel-Builer: Account for empty data here

class FunnelBuilderController < ApplicationController

	def api_read

		id = params[:job_id]

		j = Job.find(id)

		job                   = JobLocal.new
		# job.id                = j.id #TOOD: Figure out why the id method does not work for ActiveModel classes
		# job.job_id                = j.job_id
		job.local_identifier  = 'job_' + j.id.to_s
		job.hook_identifier   = j.hook_identifier
		job.subject           = j.subject
		job.content           = j.content
		job.email_list_id     = j.email_list_id
		job.app_id            = j.app_id
		job.name              = j.name
		job.client_campaign   = j.client_campaign
		# job.executed          = j.excuted
		job.execute_frequency = j.execute_frequency
		job.execute_time      = j.execute_time

		result = job.to_json

		# final_json = JSON.pretty_generate(result)

		logger.debug "Funnel-Builder INDEX VIEW JOB: " + result.to_s

		render json: result


	end


	def api_index

		width       = params[:width]
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

		campaign  = Campaign.find(campaign_id)

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

		top             = 175
		left_increment  = 160
		right_increment = 160
		@left_decrement = right_increment

		# TODO: Dynamically calculate a column-count from page-width param
		column_count    = 5

		count = 0
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

		connections    = Hash.new
		link_count     = 0
		campaign_count = 0
		last_job_id    = 0
		firstjob       = true
		
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

		data = {
			 "operators" => operators,
			 "links"     => connections
		}

		final_json = JSON.pretty_generate({
			                                   "data" => data
		                                  })

		# logger.debug "Funnel-Builder INDEX JSON: " + final_json.to_s

		render json: final_json

	end

	def index
		# Build this information as JSON

		app     = App.where(name: 'bluehelmet-dev').first
		@app_id = app.id

		if params.has_key?(:campaign_id).present?

			campaign_id = params[:campaign_id]

			@email_lists = EmailList.where(app_id: app.id)

			@local_jobs = Array.new
			campaign    = Campaign.find(campaign_id)

			Job.where(app_id: app.id, campaign_id: campaign_id).each do |j|
				p 'Adding Job ID ' + j.id.to_s

				jl                  = JobLocal.new
				jl.local_identifier = 'job_' + j.id.to_s
				# jl.hook_identifier  = campaign.hook_identifier
				jl.subject          = j.subject
				jl.content          = j.content
				jl.email_list_id    = j.email_list_id
				jl.app_id           = j.app_id
				jl.name             = j.name
				jl.client_campaign  = j.client_campaign
				@local_jobs << jl

			end

		elsif app = App.where(name: "bluehelmet-dev").first #TODO: Dynamically load App-Name here

			@array = Array.new

			@campaigns = Campaign.where(app_id: app.id)

			@campaigns.each do |c|
				@array << c.name
			end

			render :fb_campaign_select

		end

	end

	def api_update
	end

	def api_create
	end

	def api_delete
	end


end
