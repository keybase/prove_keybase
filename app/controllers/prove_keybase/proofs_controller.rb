# frozen_string_literal: true

class ProveKeybase::ProofsController < ProveKeybase::KeybaseBaseController
  before_action :user_is_logged_in!
  before_action :set_proving_username
  before_action :user_proving_own_account!

  def new
    @proof = current_user.keybase_proofs.new(
      username: params[:username],
      kb_username: params[:kb_username],
      token: params[:token]
    )
  end

  def create
    @proof = current_user.keybase_proofs.where(
      username: proof_params[:username],
      kb_username: proof_params[:kb_username]
    ).first_or_initialize
    @proof.token = proof_params[:token]

    if @proof.save
      @proof.refresh
      redirect_to @proof.on_success_path(proof_params[:kb_ua])
    else
      handle_proof_failed
    end
  end

  private

  def set_proving_username
    case params[:action]
    when 'create'
      @proving_username = proof_params[:username]
    when 'new'
      @proving_username = params[:username]
    end
  end

  def proof_params
    params.require(:proof).permit(:username, :kb_username, :token, :kb_ua)
  end
end
