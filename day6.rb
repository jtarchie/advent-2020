# frozen_string_literal: true

groups = File.read('day6.txt').split("\n\n").map { |g| g.split("\n") }

total = groups.sum do |group|
  answers = group.map { |g| g.split('') }.flatten.uniq
  answers.length
end

puts total
