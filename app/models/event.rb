class Event < ActiveRecord::Base
	def self.store(event)
		event["dateTime"] = event["dateTime"].to_datetime
		Event.create(event)
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
