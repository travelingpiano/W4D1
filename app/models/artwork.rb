# == Schema Information
#
# Table name: artworks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artwork < ApplicationRecord
  validates :title, :image_url, :artist_id, presence: true
  validates :image_url, uniqueness: true
  validates :title, uniqueness: {
    scope: :artist_id,
    message: "No duplicate title for same artist"
  }

  belongs_to :artist, dependent: :destroy,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: :User
  has_many :shares,
    primary_key: :id,
    foreign_key: :artist_id,
    class_name: :SharedArtwork
  has_many :shared_viewers,
    through: :shares,
    source: :viewer
  has_many :comments, dependent: :destroy,
    primary_key: :id,
    foreign_key: :artwork_id,
    class_name: :Comment
end
