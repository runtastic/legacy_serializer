require 'test_helper'

module LegacySerializer
  class Serializer
    class AdapterTest < Minitest::Test
      def setup
        profile = Profile.new
        @serializer = ProfileSerializer.new(profile)
        @adapter = LegacySerializer::Serializer::Adapter.new(@serializer)
      end

      def test_serializable_hash_is_abstract_method
        assert_raises(NotImplementedError) do
          @adapter.serializable_hash(only: [:name])
        end
      end

      def test_serializer
        assert_equal @serializer, @adapter.serializer
      end

      def test_adapter_class_for_known_adapter
        klass = LegacySerializer::Serializer::Adapter.adapter_class(:json_api)
        assert_equal LegacySerializer::Serializer::Adapter::JsonApi, klass
      end

      def test_adapter_class_for_unknown_adapter
        klass = LegacySerializer::Serializer::Adapter.adapter_class(:json_simple)
        assert_nil klass
      end

      def test_create_adapter
        adapter = LegacySerializer::Serializer::Adapter.create(@serializer)
        assert_equal LegacySerializer::Serializer::Adapter::Json, adapter.class
      end

      def test_create_adapter_with_override
        adapter = LegacySerializer::Serializer::Adapter.create(@serializer, { adapter: :json_api})
        assert_equal LegacySerializer::Serializer::Adapter::JsonApi, adapter.class
      end
    end
  end
end
