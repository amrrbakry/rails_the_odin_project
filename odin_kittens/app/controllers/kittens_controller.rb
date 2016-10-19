class KittensController < ApplicationController
	def new
		@kitten = Kitten.new
	end

	def create
		@kitten = Kitten.new(kitten_params)
		if @kitten.save
			flash[:success] = "You have a new kitten :)"
			redirect_to root_url
		else
			render :new
		end
	end

	def show
		@kitten = Kitten.find(params[:id])
		respond_to do |format|
			format.json { render json: @kitten }
		end
	end

	def index
		@kittens = Kitten.all
		respond_to do |format|
			format.json { render json: @kittens }
		end
	end

	def edit
		@kitten = Kitten.find(params[:id])
	end

	def update
		@kitten = Kitten.find(params[:id])
		if @kitten.update_attributes(kitten_params)
			flash[:success] = "Kitten updated successfully!"
			redirect_to @kitten
		else
			render :edit
		end
	end

	def destroy
		@kitten = Kitten.find(params[:id]).destroy
		flash[:success] = "You gave away your kitten :("
		redirect_to kittens_url
	end

	private

		def kitten_params
			params.require(:kitten).permit(:name, :age, :cuteness, :softness)
		end
end
