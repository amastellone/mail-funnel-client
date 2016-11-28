module AppProxy
	class HooksConstantsController < ApplicationController
		before_action :set_hooks_constant, only: [:show, :edit, :update, :destroy]

		# GET /hooks_constants
		# GET /hooks_constants.json
		def index
			@hooks_constants = HooksConstant.all
		end

		# GET /hooks_constants/1
		# GET /hooks_constants/1.json
		def show
		end

		# GET /hooks_constants/new
		def new
			@hooks_constant = HooksConstant.new
		end

		# GET /hooks_constants/1/edit
		def edit
		end

		# POST /hooks_constants
		# POST /hooks_constants.json
		def create
			@hooks_constant = HooksConstant.new(hooks_constant_params)

			respond_to do |format|
				if @hooks_constant.save
					format.html { redirect_to @hooks_constant, notice: 'Hooks constant was successfully created.' }
					format.json { render :show, status: :created, location: @hooks_constant }
				else
					format.html { render :new }
					format.json { render json: @hooks_constant.errors, status: :unprocessable_entity }
				end
			end
		end

		# PATCH/PUT /hooks_constants/1
		# PATCH/PUT /hooks_constants/1.json
		def update
			respond_to do |format|
				if @hooks_constant.update(hooks_constant_params)
					format.html { redirect_to @hooks_constant, notice: 'Hooks constant was successfully updated.' }
					format.json { render :show, status: :ok, location: @hooks_constant }
				else
					format.html { render :edit }
					format.json { render json: @hooks_constant.errors, status: :unprocessable_entity }
				end
			end
		end

		# DELETE /hooks_constants/1
		# DELETE /hooks_constants/1.json
		def destroy
			@hooks_constant.destroy
			respond_to do |format|
				format.html { redirect_to hooks_constants_url, notice: 'Hooks constant was successfully destroyed.' }
				format.json { head :no_content }
			end
		end

		private
		# Use callbacks to share common setup or constraints between actions.
		def set_hooks_constant
			@hooks_constant = HooksConstant.find(params[:id])
		end

		# Never trust parameters from the scary internet, only allow the white list through.
		def hooks_constant_params
			params.require(:hooks_constant).permit(:name, :identifier, :type, :hook_type)
		end
	end
end
