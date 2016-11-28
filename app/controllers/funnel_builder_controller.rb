class FunnelBuilderController < ApplicationController

	def index
		# require 'rest-client'
		serverurl = 'http://localhost:3001/api/'
		# RestClient.post serverurl + '', { app_id: 'one', nested: { param2: 'two' } }

		@tabs = []
		hooks = ["cart", "checkout", "order"]
		@chartdata = ""


		hooks.each do |hook_type|
			chartdata = StringIO.new
			chartdata << "graph TB\n" #\n

			first = true

			HooksConstant.where(hook_type: hook_type).find_each do |hook|
				if first
					chartdata << "subgraph " << hook.hook_type << " Hook\n" #\n
					first = false
				end

				campaign   = Campaign.where(hook: hook.id).first
				identifier = hook.identifier
				# Get jobs and build hashmap key / value = local_campaign
				# Loop through server Jobs
				# if Jobs.hook_identifier = identifier
				chartdata << identifier << "[" << hook.name << "]" << "==>"
				chartdata << "end\n" #\n
				# @tabs[] << chartdata

				# first = true
				# chartdata = StringIO.new
			end
			@chartdata << chartdata.string
		end

	end
end
