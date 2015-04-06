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
		agentToId = (agent) -> btoa(agent.name)
		idToAgent = (agent) -> atob(agent.name)
    
    #create svg canvas
		svg = d3.select("body").append("svg")
			.attr("width", outerWidth)
			.attr("height", outerHeight)
			.append("g")
			.attr("transform", "translate(#{margin.left},#{margin.top})")

		#visualize agents as circles
		agents = data['agents']
		events = data['events']
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
		event_groups = svg.selectAll("g.event")
		  .data(events)
		  .enter()
		  .append("g")
		  .attr("class", "event")
		event_groups.append("line")
		  .attr("x1", 0)
		  .attr("y1", 0)
		  .attr("x2", 0)
		  .attr("y2", 0)
	#end visualize

	$.ajax
		url: '/agents'
		method: 'GET'
		success: visualize