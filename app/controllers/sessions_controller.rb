class SessionsController < Clearance::SessionsController


def create
    @role = params[:session][:role]
    @user = authenticate(params) 

    sign_in(@user) do |status|
      if sign_in_successful?(status)
        redirect_to root_path
      else
        sign_out
        flash[:danger] = t(:bad_login_info)
        redirect_to sign_in_path(role: @role)
      end
    end
  end

  private
  
    def sign_in_successful?(status)
      status.success? && @user.role == @role
    end

    def url_after_destroy
      root_path
    end
end