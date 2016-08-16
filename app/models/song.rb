class Song < ActiveRecord::Base
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  def slug
    self.name.split(" ").join("-").downcase
  end

  def self.find_by_slug(slug)
    binding.pry
   @unslug = slug.split("-").map!(&:capitalize).join(" ")
   @song_instance = Song.find_by(name: @unslug)
   @song_instance.name
  end

end
