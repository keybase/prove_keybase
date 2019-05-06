module ProveKeybase
  class Engine < ::Rails::Engine
    isolate_namespace ProveKeybase

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
