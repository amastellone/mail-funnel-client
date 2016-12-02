class FunnelBuilderController < ApplicationController

	def index

	 #	  @shipment_products = [ {"old_qty_shipped"=>"324", "product_id"=>"1", "qty_shipped"=>"12443"}, 
	 #      {"old_qty_shipped"=>"4343423", "product_id"=>"3", "qty_shipped"=>"321344"} , 
	 #      {"old_qty_shipped"=>"23", "product_id"=>"4", "qty_shipped"=>"321"}]
	 #    @shipment_products.each do |p|
	 #      Product.adjust_qtys(p['old_qty_shipped'], p['qty_shipped'], p['product_id'])
	 #    end

	 	appid = App.where(name: 'bluehelmet-dev').first.id
	 	appid = App.myId()

		require 'htmlentities'


		@tabs = []
		hooks = ["cart", "checkout", "order"]
		@chartdata = ""
		@local_jobs = Array.new
		@local_jobs_hash = Hash.new

		hooks.each do |hook_type|
			chartdata = StringIO.new
			chartdata << "graph TB" << "\n"

			first = true

			HooksConstant.where(hook_type: hook_type).find_each do |hook|
				if first
					chartdata << "subgraph " << hook.hook_type << " Hook" << "\n"
					first = false
				end

				campaign   = Campaign.where(hook: hook.id).first
				identifier = hook.identifier

				chartdata << identifier << "[" << HTMLEntities.new.encode(hook.name) << "]" << "\n"

				first = true
				count = 0
				Job.where(app_id: appid, hook_identifier: identifier).find_each do |j|
					jl = JobLocal.new
					jl.local_identifier = "job_" + identifier + "_" + count
					jl.hook_identifier = identifier
					jl.subject = j.subject
					jl.content = j.content
					jl.email_list_id = j.email_list_id
					jl.name = j.name

					chartdata << "job_" << identifier << "_" << count
					chartdata << "[" << HTMLEntities.new.encode(job.name) << "]" << "\n"

					if first
						chartdata << identifier << "-->" << jk.local_identifier << "\n"
						first = false
					else
						chartdata << jl.local_identifier << "-->"
						chartdata << "job_" << identifier << "_" << (count - 1) << "\n"
					end
					
					chartdata << "click " << jl.local_identifier << " callback_" << jl.local_identifier << "\n"

					@local_jobs.push(jl)
					count = count + 1
				end

				chartdata << "end" << "\n"
				# @tabs[] << chartdata

				# first = true
				# chartdata = StringIO.new
			end
			@chartdata << chartdata.string
			# @chardata << HTMLEntities.new.encode(chardata.string)
		end

	end
end
