# frozen_string_literal: true

require ProveKeybase::Engine.root.join('app', 'controllers', 'prove_keybase', 'keybase_base_controller')

class ProveKeybase::KeybaseBaseController

  # current_user is expected to be the logged in user. In your app, this is
  # very likely already the case. If it is, you can just delete this and
  # stop reading.
  # If you don't use current_user from elsewhere, then please uncomment this.
  # It should be the logged-in user. This is also used in the view file that
  # you'll be overriding / rewriting, which is why `helper_method` is here.
  # helper_method :current_user
  # def current_user
  #   User.find_by(username: params[:username]) || User.new
  # end

  # def user_is_logged_in!
  #   handle_login_redirect unless current_user
  # end

  # def user_proving_own_account!
  #   unless current_user.username.casecmp(@proving_username).zero?
  #     handle_wrong_logged_in_user(current_user.username, @proving_username)
  #   end
  # end

  # def handle_proof_failed
  #   flash[:alert] = 'proof failed. please start again from keybase.'
  #   redirect_to new_proof_url(params: proof_params)
  # end

  # def avatar_url_from_username(username)
  #   # if you override this method, please keep the behavior
  #   # of raising an exception when a user does not exist.
  #   User.find_by!(username: username).avatar_url || 'https://example.com/default_avatar.jpg'
  # end

  # private

  # def handle_wrong_logged_in_user(logged_in_as, proving)
  #   flash[:alert] = "you're logged in as #{logged_in_as} but trying to prove #{proving}"
  #   handle_login_redirect
  # end

  # def handle_login_redirect
  #   redirect_to Rails.application.routes.url_helpers.send(ProveKeybase.configuration.login_redirection)
  # end

end
