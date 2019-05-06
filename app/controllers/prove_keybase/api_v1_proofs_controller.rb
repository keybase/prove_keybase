class ProveKeybase::ApiV1ProofsController < ProveKeybase::KeybaseBaseController
  def show
    proofs = ProveKeybase::KeybaseProof.where(username: params[:username])
    serializable_user = ProveKeybase::SerializableUser.new(proofs, avatar_url_from_username(params[:username]))
    render json: serializable_user, serializer: ProveKeybase::UserSerializer
  rescue ActiveRecord::RecordNotFound
    render json: {}, status: 404
  end
end
