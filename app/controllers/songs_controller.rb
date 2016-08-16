class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
    # binding.pry
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  get "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    @song = Song.create(params[:song])
    @song_artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.artist = @song_artist
      # binding.pry
    @song_artist.songs << @song
    @genres = params[:genre].collect do |genre|
      Genre.find(genre.to_i)
    end
    @song.genres = @genres
    @song.save
    redirect "/songs/#{@song.slug}"
  end

end
