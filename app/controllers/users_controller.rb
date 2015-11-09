# Controller for users
class UsersController < ApplicationController
  def show
    redirect_to moderator_path(current_user) if current_user.moderator?
    @user = User.find(params[:id])

    @bookcopiesnow = BookCopyUser.where(user_id: current_user.id, return_date: nil)
  end

  def index
    @book_copies = BookCopy.where(available: false,
                                  user_id: current_user.id).reject { |bc| BookCopyUser.where(book_copy_id: bc.id).last.last_date > Time.now }
  end

  def finish_signup
    return unless request.patch? && params[:user] && params[:user][:email]
    if @user.update(user_params)
      @user.skip_reconfirmation!
      sign_in(@user, bypass: true)
      redirect_to user_path(current_user)
    else
      @show_errors = true
    end
  end

  private

  def user_params
    accessible = [:name, :email]
    accessible << [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit(accessible)
  end
end
