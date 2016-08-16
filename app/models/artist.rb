#require_relative '../../lib/library_parser'

class Artist < ActiveRecord::Base
  #extend LibraryParser

  has_many :songs
  has_many :genres, through: :songs


  def slug
    self.name.split(" ").join("-").downcase
  end

  def self.find_by_slug(slug)
    self.all.detect {|artist| artist.slug == slug}
  end


end
