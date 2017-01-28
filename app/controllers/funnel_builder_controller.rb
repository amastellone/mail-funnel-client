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
		# job.client_campaign   = j.client_campaign
		job.executed          = j.executed
		job.execute_frequency = j.execute_frequency
		job.execute_time      = j.execute_time

		result = job.to_json

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

		left1         = (width.to_i - 138) / 4
		left          = 0
		top           = 0
		top_increment = 200 #Top Increment

		operators = Hash.new

		# TODO: Convert all Hash Keys to :key format and change from " to ' single quotes

		campaign  = Campaign.find(campaign_id)

		operators["campaign_0"] =
			 {
					"top"                  => top.to_s,
					"left"                 => left.to_s,
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

		top   += top_increment

		# TODO: Dynamically calculate a column-count from page-width param

		count = 0 # TODO: Add app_id again - app_id: appid,
		Job.where(campaign_id: campaign.id).each do |j|
			p 'Adding Job ID ' + appid.to_s

			jl                  = JobLocal.new
			jl.local_identifier = 'job_' + j.id.to_s
			jl.name             = j.name

			jl.hook_identifier = campaign.hook_identifier
			jl.hook_id         = j.hook_id
			jl.campaign_id     = j.campaign_id

			jl.subject = j.subject
			jl.content = j.content

			jl.email_list_id = j.email_list_id
			jl.app_id        = j.app_id
			jl.executed      = j.executed
			jl.created_at    = j.created_at
			jl.updated_at    = j.updated_at
			jl.execute_time  = j.execute_time

			@local_jobs << jl

			if jl.executed == true
				executedstring = "Executed"
			else
				executedstring = "Unexecuted"
			end

			# executetimestring = jl.created_at.in.(jl.execute_time.to_i).hours
			label = "<b>Next Job:</b> " + jl.created_at.to_s + " + " + jl.execute_time.to_s + " hrs"

			if operator_title = (jl.local_identifier).to_s
				operators[operator_title] =
					 {
							"top"                  => top.to_s,
							"left"                 => left.to_s,
							"multipleLinksOnInput" => "false",
							"properties"           => {
								 "title"   => "<b>Job:</b>" + j.name,
								 "inputs"  => {
										"input_1" => {
											 "label" => j.name
										}
								 },
								 "outputs" => {
										"output_1" => {
											 "label" => label.html_safe
										}
								 }
							}
					 }
				count                     += 1
				top                       = top + top_increment
			end
		end

		connections = Hash.new
		link_count  = 0
		last_job_id = 0
		firstjob    = true

		Job.where(campaign_id: campaign.id).each do |j|
			connector_title = ("link_" + link_count.to_s).to_s
			if firstjob
				connections[connector_title] =
					 {
							"fromOperator"  => "campaign_0",
							"fromConnector" => "output_1",
							"toOperator"    => "job_" + j.id.to_s,
							"toConnector"   => "input_1"
					 }
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
			                                   "verticalConnection" => "true",
			                                   "data"               => data,
			                                   "linkWidth"          => "20",
			                                   "grid"               => "25",
		                                  })

		# logger.debug "Funnel-Builder INDEX JSON: " + final_json.to_s

		render json: final_json
	end

	def index
		# Build this information as JSON

		app     = App.where(name: 'bluehelmet-dev').first
		@app_id = app.id

		if params.has_key?(:campaign_id).present?

			@campaign_id = params[:campaign_id]
			@campaign    = Campaign.find(@campaign_id)

			@hook = Hook.where(campaign_id: @campaign_id).first

			@email_list = EmailList.find(@campaign.email_list_id)
			@lists      = EmailList.where(app_id: app.id)

			@local_jobs = Array.new

			@height = 200

			Job.where(app_id: app.id, campaign_id: @campaign_id).each do |j|
				p 'Adding Job ID ' + j.id.to_s

				jl                  = JobLocal.new
				jl.local_identifier = 'job_' + j.id.to_s
				jl.hook_identifier  = @campaign.hook_identifier
				jl.subject          = j.subject
				jl.content          = j.content
				jl.email_list_id    = j.email_list_id
				jl.app_id           = j.app_id
				jl.name             = j.name
				@local_jobs << jl

				@height += 200

			end

		else
			app = App.where(name: "bluehelmet-dev").first #TODO: Dynamically load App-Name here

			@campaigns = Campaign.where(app_id: app.id)

			render :fb_campaign_select
		end
	end

	def api_update

		job = Job.new
		p 'Creating Job ID ' + appid.to_s

		job.name = params[:name]

		job.subject = params[:subject]
		job.content = params[:content]

		job.email_list_id = params[:email_list_id]
		job.executed      = params[:executed]
		job.updated_at    = DateTime.now
		job.execute_time  = params[:execute_time]
		job.save

		final_json = JSON.pretty_generate(result = {
			 "status" => "true"
		})

		render json: final_json
	end

	def api_create

		job = Job.new
		p 'Creating Job ID ' + appid.to_s

		job.name = params[:name]

		job.subject = params[:subject]
		job.content = params[:content]

		job.app_id      = 1 # TODO: Update the app ID
		job.campaign_id = params[:campaign_id]

		job.email_list_id = params[:email_list_id]
		job.executed      = params[:executed]
		job.updated_at    = DateTime.now
		job.created_at    = DateTime.now
		job.execute_time  = params[:execute_time]
		job.save

		final_json = JSON.pretty_generate(result = {
			 "status" => "true"
		})

		render json: final_json
	end

	def api_update_list

		campaign_id = params[:campaign_id]
		list_id     = params[:email_list_id]

		campaign               = Campaign.find(campaign_id)
		campaign.email_list_id = list_id
		campaign.save

	end

	def api_delete
		job_id = params[:job_id]
		@job   = Job.delete(job_id)

		# @job.destroy!

		if true
			final_json = JSON.pretty_generate(result = {
				 "status" => "true"
			})
		else
			final_json = JSON.pretty_generate(result = {
				 "status" => "false"
			})
		end

		render json: final_json

	end
end
