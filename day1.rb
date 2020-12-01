# frozen_string_literal: true

tracked = {}
numbers = File.read("day1.txt").split("\n").map(&:to_i)

numbers.each do |num|
  tracked[num] = true
end

first = tracked.keys.find do |num|
  tracked.has_key?(2020 - num)
end

second = 2020 - first
puts first * second