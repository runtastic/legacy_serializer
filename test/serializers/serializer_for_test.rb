require 'test_helper'

module LegacySerializer
  class Serializer
    class SerializerForTest < Minitest::Test
      class ArraySerializerTest < Minitest::Test
        def setup
          @array = [1, 2, 3]
          @previous_array_serializer = LegacySerializer::Serializer.config.array_serializer
        end

        def teardown
          LegacySerializer::Serializer.config.array_serializer = @previous_array_serializer
        end

        def test_serializer_for_array
          serializer = LegacySerializer::Serializer.serializer_for(@array)
          assert_equal LegacySerializer::Serializer.config.array_serializer, serializer
        end

        def test_overwritten_serializer_for_array
          new_array_serializer = Class.new
          LegacySerializer::Serializer.config.array_serializer = new_array_serializer
          serializer = LegacySerializer::Serializer.serializer_for(@array)
          assert_equal new_array_serializer, serializer
        end
      end

      class SerializerTest <  Minitest::Test
        class MyProfile < Profile
        end

        class Star < Like
          def self.serializer_class
            SuperStarSerializer
          end
        end

        class SuperStarSerializer < LegacySerializer::Serializer
          attributes :user_id
        end

        def setup
          @profile = Profile.new
          @my_profile = MyProfile.new
          @model = ::Model.new
        end

        def test_serializer_for_existing_serializer
          serializer = LegacySerializer::Serializer.serializer_for(@profile)
          assert_equal ProfileSerializer, serializer
        end

        def test_serializer_for_not_existing_serializer
          serializer = LegacySerializer::Serializer.serializer_for(@model)
          assert_equal nil, serializer
        end

        def test_serializer_inherited_serializer
          serializer = LegacySerializer::Serializer.serializer_for(@my_profile)
          assert_equal ProfileSerializer, serializer
        end

        def test_serializer_with_serializer_class_method
          serializer = LegacySerializer::Serializer.serializer_for(Like.new)
          assert_equal RetweetSerializer, serializer
        end

        def test_inherited_serializer_with_overriden_serializer_class_method
          serializer = LegacySerializer::Serializer.serializer_for(Star.new)
          assert_equal SuperStarSerializer, serializer
        end

      end
    end
  end
end
