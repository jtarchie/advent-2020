# frozen_string_literal: true

list_of_rules = File.readlines('day7.txt')

rules = {}
list_of_rules.each do |rule|
  holding_color = rule.scan(/^(.*) bags contain/).flatten.first
  containing_colors = rule.scan(/(\d+) (.*?) bags?[,.]{1}/).map do |num, color|
    [color, num]
  end.to_h

  rules[holding_color] = containing_colors
end

lookup = [['shiny gold']]
containing_colors = rules.values.map(&:keys).flatten

until containing_colors.intersection(lookup.last).empty?
  lookup << rules.filter_map do |holding, contained|
    holding unless contained.keys.intersection(lookup.last).empty?
  end
end

puts lookup[1..-1].flatten.uniq.size
