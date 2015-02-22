class Comment
  include Mongoid::Document
  field :commenter, type: String
  field :body, type: String

  
  belongs_to :article
end
