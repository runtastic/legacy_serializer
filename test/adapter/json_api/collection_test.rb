require 'test_helper'

module LegacySerializer
  class Serializer
    class Adapter
      class JsonApi
        class CollectionTest < Minitest::Test
          def setup
            @author = Author.new(id: 1, name: 'Steve K.')
            @author.bio = nil
            @first_post = Post.new(id: 1, title: 'Hello!!', body: 'Hello, world!!')
            @second_post = Post.new(id: 2, title: 'New Post', body: 'Body')
            @first_post.comments = []
            @second_post.comments = []
            @first_post.author = @author
            @second_post.author = @author
            @author.posts = [@first_post, @second_post]

            @serializer = ArraySerializer.new([@first_post, @second_post])
            @adapter = LegacySerializer::Serializer::Adapter::JsonApi.new(@serializer)
          end

          def test_include_multiple_posts
            assert_equal([
                           { title: "Hello!!", body: "Hello, world!!", id: "1", links: { comments: [], author: "1" } },
                           { title: "New Post", body: "Body", id: "2", links: { comments: [], author: "1" } }
                         ], @adapter.serializable_hash[:posts])
          end
        end
      end
    end
  end
end
