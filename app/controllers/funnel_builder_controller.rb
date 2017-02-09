require 'htmlentities'
require 'JobLocal'
require 'date'

# TODO: Funnel-Builer: Account for empty data here

class FunnelBuilderController < ApplicationController

	def api_read

		id = params[:job_id]

		j = Job.find(id)

		job_queue = JobQueue.where(j.queue_identifier)

		# No Need to create a new local Job, just return a json array of the job
		# and print them out in the modal, then you can just call a function update 
		# with the new inputs

		result = j.to_json
		# append job_queue info to the result

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
		top_increment = 125 #Top Increment

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

		top   += (top_increment - 28) #First Link doesn't have all boxes so adjust the first link by size of box (28px)

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

			# Add the execute time to the time it was created to find the next execute time
			date = DateTime.parse(jl.created_at) # Convert Timestamp to DateTime Object
			add_time = jl.execute_time # Get jobs execute time
			date = date + add_time.hours # Add jobs execute time to DateTime Object
			label = "Next Job: " + date.strftime('%c') 

			if operator_title = (jl.local_identifier).to_s
				operators[operator_title] =
					 {
							"top"                  => top.to_s,
							"left"                 => left.to_s,
							"multipleLinksOnInput" => "false",
							"properties"           => {
								 "title"   => "<b>Job: </b>" + j.name,
								 "inputs"  => {
										"input_1" => {
											 "label" => "Job ID: " + j.id.to_s
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
				top                       += top_increment
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

		data = JSON.pretty_generate({
			 "operators" => operators,
			 "links"     => connections
		})


		# This is unecessarry, just return the data as a json and set the options in 
		# the JS file so that you can add callback functions to it
		#final_json = JSON.pretty_generate({
		#	                                   "verticalConnection" => "true",
		#	                                   "data"               => data,
		#	                                   "linkWidth"          => "20",
		#	                                   "grid"               => "25",
		#	                                   "canUserEditLinks" => false,
      	#									   "canUserMoveOperators" => false 
		#                                 })
		#logger.debug "Funnel-Builder INDEX JSON: " + final_json.to_s

		render json: data
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

		#Find the Job from the DB
		job = Job.find(params[:job_id])

		#Update the Job with the new values
		job.name = params[:name]
		job.subject = params[:subject]
		job.content = params[:content]
		job.execute_time = params[:execute_time]

		#if executed
		if job.executed 
			job.executed = false
		end

		#Set Job updated_at to now and save to DB
		job.updated_at    = DateTime.now
		job.save

		final_json = JSON.pretty_generate(result = {
			 "status" => true
		})

		render json: final_json
	end

	def api_create

		#Create a new Job Object
		job = Job.new

		# Set Job values to values passed from AJAX call
		job.app_id      = params[:app_id]
		job.campaign_id = params[:campaign_id]
		job.name = params[:name]
		job.subject = params[:subject]
		job.content = params[:content]
		job.email_list_id = params[:email_list_id]
		job.executed      = false
		job.updated_at    = DateTime.now
		job.created_at    = DateTime.now
		job.execute_time  = params[:execute_time]

		# Save the job in the DB
		newJobSaved = job.save!


		# Check to see if the job was saved and return correct JSON response
		if newJobSaved 
			final_json = JSON.pretty_generate(result = {
			 "status" => true
			})
		else 
			final_json = JSON.pretty_generate(result = {
			 "status" => false
			})
		end

		# Return JSON response
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

		# TODO: Make sure the delete works, and responds true or false status if it worked

		if true
			final_json = JSON.pretty_generate(result = {
				 "status" => true
			})
		else
			final_json = JSON.pretty_generate(result = {
				 "status" => false
			})
		end

		render json: final_json

	end
end
