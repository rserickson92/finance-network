class Agent < ActiveRecord::Base
  def self.store(agent)
	agent["worth"] = (agent["worth"]*100).to_i
	Agent.create(agent)
  end

  def self.load_all
  	agent_records = Agent.all
  	agents = []
  	agent_records.each do |ar|
  		agent = {name: ar.name, agentType: ar.agentType, worth: ar.worth.to_s}
  		agent[:worth].insert -3, '.'
  		agents.append agent
  	end
  	agents
  end
end
