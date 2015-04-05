class Agent < ActiveRecord::Base
  def self.store(agent)
		agent["worth"] = (agent["worth"]*100).to_i
		Agent.create(agent)
	end
end
