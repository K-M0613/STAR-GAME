class Public::GamesController < ApplicationController
  def search
    if params[:keyword]
      @games = RakutenWebService::Books::Game.search(title: params[:keyword])
    end
  end
end
