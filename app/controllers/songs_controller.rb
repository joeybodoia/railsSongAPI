class SongsController < ApplicationController

    before_action :get_song, only: [:show,:update,:destroy]

    def index
        render json: {status:200,songs:Song.all}
        # render sql using sql:
        # render json: ActiveRecord::Base.connection.execute('SELECT * FROM songs;')
    end

    def show
        # song = Song.find(params[:id])
        render json: {status:200,songs:@song}
    end

    def create
        p params
        # song = params.required(:song).permit(:title,:artist_name,:artwork)
        song = Song.new(song_params)
        if song.save
            render(status:201, json: {song:song})
        else
            render(status:422, json: {song:song})
        end
    end

    def update
        # song = Song.find(params[:id])
        @song.update(song_params) 
        render(json: {song:@song})
    end

    def destroy
        # song = Song.destroy(params[:id])
        @song.destroy
        render(status:204)
    end


    private
    def song_params
        return params.required(:song).permit(:title,:artist_name,:artwork)
    end

    def get_song
        @song = Song.find(params[:id])
    end
end