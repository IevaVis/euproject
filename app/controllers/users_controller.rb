class UsersController < Clearance::UsersController
	before_action :require_login, except: :create

	def new
		@user = User.new
	end

	def create
		@user = User.new(valid_params)
		if @user.save
			sign_in @user
			flash[:success] = "You have signed up successfully!"
			redirect_to root_path
		else
			flash[:alert] = @user.errors.full_messages.join(',')
			render template: "users/new"
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(valid_params)
			redirect_to user_path(@user)
		else
			render template: "users/edit"
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to root_path
	end


	private

	def valid_params
		params.require(:user).permit(:name, :country, :email, :password, :role, :grade_of_teaching)
	end

	def require_login
		if !current_user
			redirect_to root_path
		end
	end

end