# !/usr/bin/env ruby

require 'graphviz'

g = GraphViz.new(:G, type: :digraph)
nodes = {}
states = %w( new_connection checking_user creating_user authenticating_user playing )

states.each do |state|
  nodes[state] = g.add_nodes(state)
end

g.add_edges(nodes['new_connection'], nodes['checking_user'])
g.add_edges(nodes['checking_user'], nodes['creating_user'])
g.add_edges(nodes['checking_user'], nodes['authenticating_user'])
g.add_edges(nodes['creating_user'], nodes['playing'])
g.add_edges(nodes['authenticating_user'], nodes['authenticating_user'])
g.add_edges(nodes['authenticating_user'], nodes['playing'])

g.output(png: 'states_chart.png')
