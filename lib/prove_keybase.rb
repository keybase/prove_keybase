require 'active_support/all'
require 'active_record'
require 'active_model_serializers'
require 'faraday'
require 'faraday_middleware'

require 'prove_keybase/engine'
require 'prove_keybase/is_keybase_provable'
require 'prove_keybase/keybase_adapter'
require 'prove_keybase/keybase_client'
require 'prove_keybase/configuration'

ActiveSupport.on_load(:active_record) do
  include ProveKeybase::Model
end
