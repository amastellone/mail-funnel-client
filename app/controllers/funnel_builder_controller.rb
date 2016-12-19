require 'htmlentities'
require 'JobLocal'

# TODO: Funnel-Builer: Account for empty data here

class FunnelBuilderController < ApplicationController

	def index
		# Build this information as JSON

		app = App.where(name: 'bluehelmet-dev').first
		appid = app.id
		@local_jobs  = Array.new

		@email_lists = EmailList.where(app_id: appid)

		# hook_type_id = params[:id]
		hook_type_id = 1

		hook_request = 'first'
		if hook_request != 'all'
			@hook_type = HookType.first
		else
			@hook_type = HookType.all
		end

		# hook_type_id = params[:id]
		hook_type_id = 1

		hook_request = 'first'
		if hook_request != 'all'
			first_hook = HooksConstant.where(hook_type_id: @hook_type.id).first
			@hooks     = HooksConstant.where(id: first_hook.id).all
		else
			@hooks = HooksConstant.where(hook_type_id: @hook_type.id).all
		end

		@local_jobs = Array.new
		first       = true

		top           = 0
		top_increment = 150 #Top Increment
		left          = 80

		count     = 0
		operators = Hash.new

		# Print Campaigns (Hooks)
		@hooks.each do |hook|
			Campaign.where(hooks_constant_id: hook.id).each do |campaign|

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
		end

		top            = 175
		left_increment = 160

		count = 0
		@hooks.each do |hook|
			Campaign.where(hooks_constant_id: hook.id).each do |campaign|

				left = 0
				Job.where(app_id: appid, client_campaign: campaign.id).each do |j|
					if count % 5 == 0 && count != 0
						left = 0
						top = top + top_increment
					end
					p "Adding Job ID " + appid.to_s

					jl                  = JobLocal.new
					jl.local_identifier = "job_" + j.id.to_s
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
					count                     += 1
				end
				top = top + top_increment
			end
		end


		connections    = Hash.new
		link_count     = 0
		campaign_count = 0
		job_count      = 0
		last_job_id    = 0
		@hooks.each do |hook|
			Campaign.where(hooks_constant_id: hook.id).each do |campaign|
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
		end

		object = JSON.pretty_generate({
			                               "operators" => operators,
			                               "links"     => connections
		                              })
		@json  = object

	end

	def index_mermaid

		appid = App.where(name: 'bluehelmet-dev').first.id
		# appid = App.myId() # TODO: Implement App-Name Here

		require 'htmlentities'
		require 'JobLocal'

		if request.get?
			if params.include?(:hook_type)
				hook_type = params[:hook_type]
				@hooks    = HooksConstant.where(hook_type: hook_type)
			else
				@hooks = HooksConstant.all
			end
		else
			@hooks = HooksConstant.all
		end


		@chartdata       = ""
		@local_jobs      = Array.new
		@local_jobs_hash = Hash.new

		first = true
		@hooks.each do |hook|
			chartdata = StringIO.new
			chartdata << "graph TB" << "\n"

			if first
				chartdata << "subgraph " << hook.hook_type << " Hook" << "\n"
				first = false
			end

			campaign   = Campaign.where(hook: hook.id).first
			identifier = hook.identifier

			chartdata << identifier << "[" << HTMLEntities.new.encode(hook.name) << "]" << "\n"

			firstjob = true
			count    = 0
			Job.where(app_id: appid, hook_identifier: identifier).each do |j|
				p "Adding Job ID " + appid.to_s
				jl                  = JobLocal.new
				jl.local_identifier = "job_" + identifier + "_" + count.to_s
				jl.hook_identifier  = identifier
				jl.subject          = j.subject
				jl.content          = j.content
				jl.email_list_id    = j.email_list_id
				jl.name             = j.name
				@local_jobs << jl

				chartdata << "job_" << identifier << "_" << count.to_s
				chartdata << "[" << HTMLEntities.new.encode(jl.name) << "]" << "\n"

				if firstjob
					chartdata << identifier << "-->" << jl.local_identifier << "\n"
					firstjob = false
				else
					chartdata << jl.local_identifier << "-->"
					chartdata << "job_" << identifier << "_" << (count - 1) << "\n"
				end

				chartdata << "click " << jl.local_identifier << " callback_" << jl.local_identifier << "\n"

				count = count + 1
			end

			chartdata << "%% HOOK_APPEND_" << identifier << "\n"

			chartdata << "end" << "\n"

			@chartdata << chartdata.string
			chartdata = StringIO.new
		end
		# @chartdata << chartdata.string
		# @chardata << HTMLEntities.new.encode(chardata.string)
	end

end
