class UsersController < Clearance::UsersController
	before_action :require_login, except: :create
	add_breadcrumb "Home", :root_path

	def new
		add_breadcrumb "Edit profile"
		@user = User.new
	end

	def create
		@user = User.new(valid_params)
		if @user.save
			UserMailer.with(user: @user).welcome_email.deliver_now
			sign_in @user
			flash[:success] = "You have signed up successfully!"
			redirect_to root_path
		else
			render template: "users/new"
		end
	end

	def show
		add_breadcrumb "Profile page", :user_path
		@user = User.find(params[:id])
	end

	def edit
		add_breadcrumb "Edit profile" 
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(valid_params)
			redirect_to root_path
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
		params.require(:user).permit(:name, :country, :email, :password, :role, :grade_of_teaching, :terms)
	end

	def require_login
		if !current_user
			redirect_to root_path
		end
	end

end