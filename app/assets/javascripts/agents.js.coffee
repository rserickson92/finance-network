$ ->
	visualize = (data) ->
		#'global' variables for controlling canvas size
		margin = {top: 20, right: 20, bottom: 20, left: 60}
		padding = {top: 60, right: 60, bottom: 60, left: 60}
		outerWidth = 2000
		outerHeight = 500
		innerWidth = outerWidth - margin.left - margin.right
		innerHeight = outerHeight - margin.top - margin.bottom
		w = innerWidth - padding.left - padding.right
		h = innerHeight - padding.top - padding.bottom

    #utility functions
		formatWorth = (worth) ->
		  s = worth.toString()
		  l = s.length
		  "$#{s.slice(0, l - 2)}.#{s.slice(l - 2, l)}"
		agentToId = (agent) -> agent.name.replace(/ /g, '')
    
    #create svg canvas
		svg = d3.select("body").append("svg")
			.attr("width", outerWidth)
			.attr("height", outerHeight)
		  .append("g")
			.attr("transform", "translate(#{margin.left},#{margin.top})")

		#visualize agents as circles
		agents = data['agents']
		xScale = d3.scale.linear()
			.domain([0, agents.length]).nice()
			.range([0, w])
		yScale = d3.scale.linear()
			.domain([0, d3.max(agents, (agent) -> agent.worth)]).nice()
			.range([h, 0])
		xPos = (agent, i) -> xScale(i)
		yPos = (agent, i) -> yScale(agent.worth)
		agent_groups = svg.selectAll("g.agent")
			.data(agents)
			.enter()
			.append("g")
			.attr("class", "agent")
			.attr("id", agentToId)
		agent_groups.append("circle")
			.attr("cx", xPos)
			.attr("cy", yPos)
			.attr("r", 8)
		agent_groups.append("text")
			.attr("class", "label")
			.text((agent) -> "#{agent.name}: #{formatWorth(agent.worth)}")
			.attr("x", xPos)
			.attr("y", yPos)

		#add display of agent name and worth only when mousing over
		$("g.agent").mouseenter () -> $(@).find("text").show()
		$("g.agent").mouseleave () -> $(@).find("text").hide()

		#visualize events as lines
		events = data['events']
		x1 = (event) ->
			fromAgent = $("##{event.from.replace(/ /g, '')}")
			fromAgent.find("circle").attr("cx")
		y1 = (event) ->
			fromAgent = $("##{event.from.replace(/ /g, '')}")
			fromAgent.find("circle").attr("cy")
		x2 = (event) ->
			toAgent = $("##{event.to.replace(/ /g, '')}")
			toAgent.find("circle").attr("cx")
		y2 = (event) ->
			toAgent = $("##{event.to.replace(/ /g, '')}")
			toAgent.find("circle").attr("cy")
		event_groups = svg.selectAll("g.event")
		  .data(events)
		  .enter()
		  .append("g")
		  .attr("class", "event")
		event_groups.append("line")
		  .attr "stroke-width", 5
		  .attr "stroke", "gray" 
			.attr "x1", x1
			.attr "y1", y1
			.attr "x2", x2
			.attr "y2", y2
		event_groups.append("text")
		  .attr("class", "label")
		  .text((event) -> "amount: #{formatWorth(event.amount)}")
		  .attr "x", (event) -> (parseFloat(x1(event)) + parseFloat(x2(event))) / 2
		  .attr "y", (event) -> (parseFloat(y1(event)) + parseFloat(y2(event))) / 2
		$("g.event").mouseenter () -> $(@).find("text").show()
		$("g.event").mouseleave () -> $(@).find("text").hide()
	#end visualize

	$.ajax
		url: '/agents'
		method: 'GET'
		success: visualize