require 'test_helper'

module LegacySerializer
  class Serializer
    class ConfigurationTest < Minitest::Test
      def test_array_serializer
        assert_equal LegacySerializer::Serializer::ArraySerializer, LegacySerializer::Serializer.config.array_serializer
      end

      def test_default_adapter
        assert_equal :json, LegacySerializer::Serializer.config.adapter
      end
    end
  end
end
