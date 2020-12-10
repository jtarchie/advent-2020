# frozen_string_literal: true

adapters = File.readlines('day10.txt').map(&:to_i).sort
adapters.push(adapters.last + 3)
adapters.unshift(0)

diffs = adapters.each_cons(2).map { |left, right| right - left }
tallied = diffs.tally

puts tallied[1] * tallied[3]
