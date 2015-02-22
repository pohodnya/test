class Tag
  include Mongoid::Document
  field :tag, type: String
  
  validates :tag, uniqueness: true, length: {minimum: 3}
  
  has_and_belongs_to_many :articles
  accepts_nested_attributes_for :articles
end
