# frozen_string_literal: true

require ProveKeybase::Engine.root.join('app', 'controllers', 'prove_keybase', 'keybase_base_controller')

class ProveKeybase::KeybaseBaseController
  def handle_wrong_logged_in_user(logged_in_as, proving)
    flash[:alert] = "overridden you're logged in as #{logged_in_as} but trying to prove #{proving}"
    redirect_to Rails.application.routes.url_helpers.root_url
  end
end
