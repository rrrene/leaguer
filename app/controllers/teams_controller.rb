class TeamsController < ApplicationController
  def index
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      flash[:notice] = "Team has been created."
      redirect_to @team
    else
      # nothing, yet
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name,:address1)
  end
end