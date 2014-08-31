class WelcomeController < ApplicationController
  def index
    @battles = Battle.all
  end
end
