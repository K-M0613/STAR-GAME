class Public::GamesController < ApplicationController
  before_action :authenticate_user!
  def search
    if params[:keyword]
      @games = RakutenWebService::Books::Game.search(title: params[:keyword])
    end
  end
end
