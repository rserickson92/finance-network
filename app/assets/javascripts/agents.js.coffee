$ ->
	#'global' variables for controlling canvas size
	margin = {top: 20, right: 20, bottom: 20, left: 60}
	padding = {top: 60, right: 60, bottom: 60, left: 60}
	outerWidth = 1500
	outerHeight = 600
	innerWidth = outerWidth - margin.left - margin.right
	innerHeight = outerHeight - margin.top - margin.bottom
	w = innerWidth - padding.left - padding.right
	h = innerHeight - padding.top - padding.bottom

	#utility functions for visualize()
	formatWorth = (worth) ->
		s = worth.toString()
		l = s.length
		"$#{s.slice(0, l - 2)}.#{s.slice(l - 2, l)}"
	agentToId = (agent) -> agent.name.replace(/ /g, '')
	bindLabelDisplayEvent = (selector) ->
		$(selector).mouseenter () -> $(@).find("text").show()
		$(selector).mouseleave () -> $(@).find("text").hide()
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

	visualize = (data) ->
		agents = data['agents']
		events = data['events']
		xScale = d3.scale.linear()
			.domain([0, agents.length]).nice()
			.range([0, w])
		yScale = d3.scale.log()
			.domain([1, d3.max(agents, (agent) -> agent.worth)]).nice()
			.range([h, 0])
		xPos = (agent, i) -> xScale(i)
		yPos = (agent, i) ->
		  if agent.worth < 1 then 1 else yScale(agent.worth)

    #create svg canvas
		svg = d3.select("#vis-container").append("svg")
			.attr("width", outerWidth)
			.attr("height", outerHeight)
		  .append("g")
		  .attr("id", "vis")
			.attr("transform", "translate(#{margin.left},#{margin.top})")

		#visualize agents as circles
		agent_groups = svg.selectAll("g.agent")
			.data(agents)
			.enter()
			.append("g")
			.attr("class", "agent")
			.attr("id", agentToId)
		agent_groups.append("circle")
			.attr("cx", xPos)
			.attr("cy", yPos)
			.attr("r", 10)

		#visualize events as lines
		event_groups = svg.selectAll("g.event")
		  .data(events)
		  .enter()
		  .append("g")
		  .attr("class", "event")
		event_groups.append("line")
			.attr "x1", x1
			.attr "y1", y1
			.attr "x2", x2
			.attr "y2", y2

		#hack to put circles in front of lines
		removed_agents = $("g.agent").remove()
		$("#vis").append(removed_agents)

    #add text last so it is visible
		agent_groups = svg.selectAll("g.agent")
		agent_groups.append("text")
			.attr("class", "label")
			.text((agent) -> "#{agent.name}: #{formatWorth(agent.worth)}")
			.attr("x", xPos)
			.attr("y", (agent, i) -> yPos(agent, i) - 10)
		event_groups.append("text")
			.attr("class", "label")
			.text((event) -> "#{formatWorth(event.amount)}: #{event.eventType}")
			.attr "x", (event) -> (parseFloat(x1(event)) + parseFloat(x2(event))) / 2
			.attr "y", (event) -> (parseFloat(y1(event)) + parseFloat(y2(event))) / 2
		#add display of info only when mousing over
		bindLabelDisplayEvent("g.agent")
		bindLabelDisplayEvent("g.event")
	#end visualize

  #get data for visualization
	$.ajax
		url: '/agents'
		method: 'GET'
		success: visualize

	#button logic
	eventsOn = true
	agentsOn = true
	$("#toggle-events").on 'click', ->
		if eventsOn then $("g.event").trigger("mouseenter") else $("g.event").trigger("mouseleave")
		eventsOn = !eventsOn
	$('#toggle-agents').on 'click', ->
		if agentsOn then $("g.agent").trigger("mouseenter") else $("g.agent").trigger("mouseleave")
		agentsOn = !agentsOn
	toggle_shadow = -> $(@).toggleClass("button-shadow")
	$('button').hover toggle_shadow, toggle_shadow