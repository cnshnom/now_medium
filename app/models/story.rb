class Story < ApplicationRecord
  acts_as_paranoid

  extend FriendlyId
  friendly_id :slug_candidate, use: :slugged

  include AASM

  

  # relationships
  belongs_to :user
  has_one_attached :cover_image


   # validations
  validates :title, presence: true

  

  # scopes

  scope :published_stories, -> { published.with_attached_cover_image.order(created_at: :desc).includes(:user) }


   # instance methods
  def destroy
    update(deleted_at: Time.now)
  end


  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end

  aasm(column: 'status', no_direct_assignment: true) do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end

  end

  private

  def slug_candidate
    [
      :title,
      [:title, SecureRandom.hex[0, 8]]
    ]
  end

end
