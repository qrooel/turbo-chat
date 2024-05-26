# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    before_action :check_user_role, only: [:create]

    private

    def check_user_role
      user = User.find_by(email: params[:user][:email])

      if user.present? && !user.admin?
        redirect_to new_user_session_path, alert: 'You are not authorized.'
      end
    end

  end
end
