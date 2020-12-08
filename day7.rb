# frozen_string_literal: true

list_of_rules = File.readlines('day7.txt')

Rule = Struct.new(:name, :quantity) do
end

class Rules
  def initialize(filename)
    @filename = filename
  end

  def rules
    @rules ||= begin
      rules = {}
      lines.each do |rule|
        holding_color = rule.scan(/^(.*) bags contain/).flatten.first
        containing_colors = rule.scan(/(\d+) (.*?) bags?[,.]{1}/).map do |quantity, color|
          Rule.new(color, quantity.to_i)
        end

        rules[holding_color] = containing_colors
      end
      rules
    end
  end

  def all_colors_contained_within_color
    rules.values.flatten.map(&:name)
  end

  def find_colors_containing(colors)
    rules.filter_map do |holding, contained|
      holding unless contained.map(&:name).intersection(colors).empty?
    end
  end

  def number_of_bags_color_contains(color_name)
    rules.fetch(color_name, [0]).sum do |rule|
      rule.quantity * (number_of_bags_color_contains(rule.name) + 1)
    end
  end

  private

  def lines
    @lines ||= File.readlines(@filename)
  end
end

rules = Rules.new('day7.txt')

puts rules.number_of_bags_color_contains('shiny gold')
