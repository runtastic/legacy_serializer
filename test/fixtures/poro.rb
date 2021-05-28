class Model
  def initialize(hash={})
    @attributes = hash
  end

  def read_attribute_for_serialization(name)
    if name == :id || name == 'id'
      id
    else
      @attributes[name]
    end
  end

  def id
    @attributes[:id] || @attributes['id'] || object_id
  end

  def method_missing(meth, *args)
    if meth.to_s =~ /^(.*)=$/
      @attributes[$1.to_sym] = args[0]
    elsif @attributes.key?(meth)
      @attributes[meth]
    else
      super
    end
  end
end

class Profile < Model
end

class ProfileSerializer < LegacySerializer::Serializer
  attributes :name, :description

  urls :posts, :comments
end

class ProfilePreviewSerializer < LegacySerializer::Serializer
  attributes :name

  urls :posts, :comments
end

Post = Class.new(Model)
Comment = Class.new(Model)
Author = Class.new(Model)
Bio = Class.new(Model)
Blog = Class.new(Model)
Role = Class.new(Model)
Like = Class.new(Model) do
  def self.serializer_class
    RetweetSerializer
  end
end

RetweetSerializer = Class.new(LegacySerializer::Serializer) do
  attributes :date
end

PostSerializer = Class.new(LegacySerializer::Serializer) do
  attributes :title, :body, :id

  has_many :comments
  belongs_to :author
  url :comments
end

CommentSerializer = Class.new(LegacySerializer::Serializer) do
  attributes :id, :body

  belongs_to :post
  belongs_to :author
end

AuthorSerializer = Class.new(LegacySerializer::Serializer) do
  attributes :id, :name

  has_many :posts, embed: :ids
  has_many :roles, embed: :ids
  belongs_to :bio
end

RoleSerializer = Class.new(LegacySerializer::Serializer) do
  attributes :id, :name

  belongs_to :author
end

BioSerializer = Class.new(LegacySerializer::Serializer) do
  attributes :id, :content

  belongs_to :author
end

BlogSerializer = Class.new(LegacySerializer::Serializer) do
  attributes :id, :name

  belongs_to :writer
  has_many :articles
end

PaginatedSerializer = Class.new(LegacySerializer::Serializer::ArraySerializer) do
  def json_key
    'paginated'
  end
end

AlternateBlogSerializer = Class.new(LegacySerializer::Serializer) do
  attribute :id
  attribute :name, key: :title
end
