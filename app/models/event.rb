class Event < ActiveRecord::Base
	def self.store(event)
		event["dateTime"] = event["dateTime"].to_datetime
		amt = (event["amount"]*100).to_i
		event["amount"] = amt
		Event.create(event)

		fromAgent = Agent.find_by_name(event["fromAgent"])
		toAgent = Agent.find_by_name(event["toAgent"])
		fromAgent.update(worth: fromAgent.worth - amt)
		toAgent.update(worth: toAgent.worth + amt)
	end

	def self.load_all
		event_records = Event.all
		events = []
		event_records.each do |er|
			event = {amount: er.amount, from: er.fromAgent, 
				       to: er.toAgent, eventType: er.eventType,
				       date: er.dateTime.iso8601}
			events.append event
		end
		events
	end
end
