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

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  # {"_method"=>"patch",
  #  "song"=>{"name"=>"Rolling In the Deep2"},
  #  "artist"=>{"name"=>"Adele"},
  #  "genre"=>["3"],
  #  "splat"=>[],
  #  "captures"=>["rolling-in-the-deep"],
  #  "slug"=>"rolling-in-the-deep"}

  patch "/songs/:slug" do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.save
    #flash[:message] = "Successfully updated song."
    redirect("/songs/#{params[:slug]}")
  end


end
