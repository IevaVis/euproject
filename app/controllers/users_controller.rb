class UsersController < Clearance::UsersController
	before_action :require_login, except: :create
	before_action :authorize_user, only: [:show, :edit, :update, :destroy]
	add_breadcrumb "Home", :root_path

	def new
		add_breadcrumb "Edit profile"
		@user = User.new
	end

	def create
		@role = params[:user][:role]
		@user = User.new(valid_params)
		if @user.save
			UserMailer.with(user: @user).welcome_email.deliver_now
			sign_in @user
			flash[:success] = t(:successful_registration)
			redirect_to root_path
		else
			redirect_to sign_up_path(role: @role)
			flash[:danger] = @user.errors.full_messages.join(', ') 
		end
	end

	def show
		add_breadcrumb "User profile & Uploads"
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

	def authorize_user 
      @user = User.find(params[:id])
      redirect_to root_url unless current_user == @user
    end

end