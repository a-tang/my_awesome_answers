class Question < ActiveRecord::Base

  # when using `has_many` you must put a symbol for the associated record in
  # plural format
  # you also should provide the :dependent option which can be either:
  # :destroy: which deletes all the associated answers when the question is deleted
  # :nullify: which makes `question_id` NULL for all associated answers
  has_many :answers, dependent: :destroy
  belongs_to :category
  belongs_to :user

  has_many :likes, dependent: :destroy
  # has_many :users, through: :likes
  has_many :liking_users, through: :likes, source: :user

  has_many :votes, dependent: :destroy
  has_many :voting_users, through: :votes, source: :user

  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  # validates_presence_of :title # deprecated > likely to be removed in Rails 5
  # validates :title, :body, presence: true
  validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})

  validates :body, length: {minimum: 5}, presence: true

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :email, format: VALID_EMAIL_REGEX

  # this validates that the combination of title and body must be unique
  # it means that title by itself doesn't have to unique and body by itslef
  # doesn't have to be unique but the combination of the two must be unique
  # validates :title, uniqueness: {scope: :body}

  # we use `validate` to reference a method that will be used for our custom
  # validation
  validate :no_monkey

  # this will call the `set_defaults` method right after the initialize phase
  after_initialize :set_defaults

  before_validation :titleize_title

  extend FriendlyId
  friendly_id :title, use: :history

  # scope :recent_three, lambda { order("created_at DESC").limit(3) }
  def self.recent_three
    order("created_at DESC").limit(3)
  end

  def self.search(search_term)
    # where(["title ILIKE :term OR body ILIKE :term", {term: "%#{search_term}%"}])
    where(["title ILIKE ? OR body ILIKE ?", "%#{search_term}%", "%#{search_term}%"])
  end

  def user_full_name
    user ? user.full_name : ""
  end

  def like_for(user)
    likes.find_by_user_id user if user
  end

  def vote_for(user)
    votes.find_by_user_id user if user
  end

  def vote_value
    votes.up_count - votes.down_count
  end

  # def to_param
  #   "#{id}-#{title}".parameterize
  # end

  private

  def titleize_title
    self.title = title.titleize
  end

  def set_defaults
    self.view_count ||= 0
  end

  def no_monkey
    if title.present? && title.downcase.include?("monkey")
      errors.add(:title, "No monkeys!")
    end
  end

end
