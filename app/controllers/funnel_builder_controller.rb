class FunnelBuilderController < ApplicationController

	def index

		appid = App.where(name: 'bluehelmet-dev').first.id
		# appid = App.myId() # TODO: Implement App-Name Here

		require 'htmlentities'
		require 'JobLocal'

		if request.get?
			if params.include?(:hook_type)
				hook_type = params[:hook_type]
				@hooks = HooksConstant.where(hook_type: hook_type)
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
