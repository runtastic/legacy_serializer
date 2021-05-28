module LegacySerializer
  class Serializer
    module Configuration
      include ActiveSupport::Configurable
      extend ActiveSupport::Concern

      included do |base|
        base.config.array_serializer = LegacySerializer::Serializer::ArraySerializer
        base.config.adapter = :json
      end
    end
  end
end
