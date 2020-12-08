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
          Rule.new(color, quantity)
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

  private

  def lines
    @lines ||= File.readlines(@filename)
  end
end

rules = Rules.new('day7.txt')
stack = [['shiny gold']]

until rules.all_colors_contained_within_color.intersection(stack.last).empty?
  stack << rules.find_colors_containing(stack.last)
end

puts stack[1..-1].flatten.uniq.size
