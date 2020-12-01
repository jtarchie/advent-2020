# frozen_string_literal: true

numbers = File.read('day1.txt').split("\n").map(&:to_i)

values = numbers.combination(3).find do |nums|
  nums.sum == 2020
end

puts values.reduce(:*)
