module LegacySerializer
  class Serializer
    class AdapterForTest < Minitest::Test
      def setup
        @previous_adapter = LegacySerializer::Serializer.config.adapter
      end

      def teardown
        LegacySerializer::Serializer.config.adapter = @previous_adapter
      end

      def test_returns_default_adapter
        adapter = LegacySerializer::Serializer.adapter
        assert_equal LegacySerializer::Serializer::Adapter::Json, adapter
      end

      def test_overwrite_adapter_with_symbol
        LegacySerializer::Serializer.config.adapter = :null

        adapter = LegacySerializer::Serializer.adapter
        assert_equal LegacySerializer::Serializer::Adapter::Null, adapter
      ensure

      end

      def test_overwrite_adapter_with_class
        LegacySerializer::Serializer.config.adapter = LegacySerializer::Serializer::Adapter::Null

        adapter = LegacySerializer::Serializer.adapter
        assert_equal LegacySerializer::Serializer::Adapter::Null, adapter
      end

      def test_raises_exception_if_invalid_symbol_given
        LegacySerializer::Serializer.config.adapter = :unknown

        assert_raises ArgumentError do
          LegacySerializer::Serializer.adapter
        end
      end

      def test_raises_exception_if_it_does_not_know_hot_to_infer_adapter
        LegacySerializer::Serializer.config.adapter = 42

        assert_raises ArgumentError do
          LegacySerializer::Serializer.adapter
        end
      end
    end
  end
end
