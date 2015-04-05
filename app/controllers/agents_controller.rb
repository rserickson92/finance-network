class AgentsController < ApplicationController
  respond_to :json

  def create
  	Agent.store(agent_params)
  end

  def create_many
  	agents_params[:agents].each do |agent|
  	  Agent.store(agent)
  	end
  end

  def index
  end

  private

  def agent_params
  	params.require(:agent).permit(:worth, :name, :agentType)
  end

  def agents_params
  	params.permit(agents: [:worth, :name, :agentType])
  end
end
