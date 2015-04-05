class Event < ActiveRecord::Base
	def self.store(event)
		event["dateTime"] = event["dateTime"].to_datetime
		Event.create(event)
	end
end
