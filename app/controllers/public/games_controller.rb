class Public::GamesController < ApplicationController
  before_action :authenticate_user!
  def search
    if params[:keyword].present?
      @games = RakutenWebService::Books::Game.search(title: params[:keyword])
    else
      redirect_to request.referer
    end
  end
end
