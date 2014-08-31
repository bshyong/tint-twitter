class WelcomeController < ApplicationController
  def index
    @battles = Battle.all.order('created_at DESC')
  end
end
