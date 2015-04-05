class AgentsController < ApplicationController
  respond_to :json

  def create
  	Agent.store(agent_params)
  end

  def index
  end

  def agent_params
  	params.require(:agent).permit(:worth, :name, :agentType)
  end
end
