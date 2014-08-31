class BattlesController < ApplicationController
  before_action :set_battle, only: [:show, :edit, :update, :destroy]

  # GET /battles/new
  def new
    @battle = Battle.new
  end

  # POST /battles
  def create
    @battle = Battle.new(battle_params)

    if @battle.save
      redirect_to root_path, notice: 'Battle was successfully created.'
    else
      render :new
    end
  end

  # DELETE /battles/1
  def destroy
    @battle.update_attribute(:active, false)
    redirect_to root_path, notice: 'Battle was successfully ended.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_battle
      @battle = Battle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def battle_params
      params.require(:battle).permit(:name, :hashtag_one, :hashtag_two)
    end
end
