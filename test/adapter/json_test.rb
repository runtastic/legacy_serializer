require 'test_helper'

module LegacySerializer
  class Serializer
    class Adapter
      class JsonTest < Minitest::Test
        def setup
          @author = Author.new(id: 1, name: 'Steve K.')
          @post = Post.new(title: 'New Post', body: 'Body')
          @first_comment = Comment.new(id: 1, body: 'ZOMG A COMMENT')
          @second_comment = Comment.new(id: 2, body: 'ZOMG ANOTHER COMMENT')
          @post.comments = [@first_comment, @second_comment]
          @first_comment.post = @post
          @second_comment.post = @post
          @post.author = @author

          @serializer = PostSerializer.new(@post)
          @adapter = LegacySerializer::Serializer::Adapter::Json.new(@serializer)
        end

        def test_has_many
          assert_equal([
                         {id: 1, body: 'ZOMG A COMMENT'},
                         {id: 2, body: 'ZOMG ANOTHER COMMENT'}
                       ], @adapter.serializable_hash[:comments])
        end
      end
    end
  end
end

