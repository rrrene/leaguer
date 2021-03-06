class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  before_action :set_seasons, only: [:create, :update]

  def index
    @teams = Team.all
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.seasons |= @seasons

    if @team.save
      flash[:notice] = 'Team has been created.'
      redirect_to @team
    else
      flash[:alert] = 'Team has not been created.'

      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @team.seasons |= @seasons

    if @team.update(team_params)
      flash[:notice] = 'Team has been updated.'
      redirect_to @team
    else
      flash[:alert] = 'Team has not been updated.'
      render 'edit'
    end
  end

  def destroy
    @team.destroy

    flash[:notice] = 'Team has been deleted.'

    redirect_to teams_path
  end

  private

  def team_params
    params.require(:team).permit(:name, :address1)
  end

  def set_team
    @team = Team.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'The team you were looking for could not be found.'
    redirect_to teams_path
  end

  def set_seasons
    @seasons = Season.where(id: params[:seasons])
  end
end
