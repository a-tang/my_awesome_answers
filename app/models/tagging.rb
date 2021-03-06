class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :questions

   validates :tag_id, uniqueness: {scope: :question_id}
end
