class ProveKeybase::ConfigController < ProveKeybase::KeybaseBaseController
  def show
    render json: ProveKeybase.configuration, serializer: ProveKeybase::ConfigSerializer
  end
end