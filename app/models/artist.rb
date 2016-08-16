#require_relative '../../lib/library_parser'

class Artist < ActiveRecord::Base
  #extend LibraryParser

  has_many :songs
  has_many :genres, through: :songs


  def slug
    self.name.split(" ").join("-").downcase
  end
end
