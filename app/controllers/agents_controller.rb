class AgentsController < ApplicationController
  respond_to :json

  def create
  	Agent.store(agent_params)
    redirect_to root_path
  end

  def create_many
  	agents_params[:agents].each do |agent|
  	  Agent.store(agent)
  	end
    redirect_to root_path
  end

  def index
    @events = Event.load_all
    @agents = Agent.load_all
  end

  private

  def agent_params
  	params.require(:agent).permit(:worth, :name, :agentType)
  end

  def agents_params
  	params.permit(agents: [:worth, :name, :agentType])
  end
end
