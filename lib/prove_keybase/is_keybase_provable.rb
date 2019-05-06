module ProveKeybase
  module Model
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def is_keybase_provable
        model_class = self
        model_class.has_many :keybase_proofs, class_name: 'ProveKeybase::KeybaseProof'
      end
    end
  end
end
