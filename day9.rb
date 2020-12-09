# frozen_string_literal: true

actual = File.readlines('day9.txt').map(&:to_i)
preamble = 25

found = nil

(preamble..actual.length).step(1).each do |index|
  combinations = actual[index - preamble...index].combination(2)
  calculated_sums = combinations.map(&:sum)
  unless calculated_sums.include?(actual[index])
    found = actual[index]
    break
  end
end

puts found

starting = 0
ending = 0
sum = 0

0.upto(actual.length - 1).each do |index|
  sum += actual[index]

  while sum > found
    sum -= actual[starting]
    starting += 1
  end

  if sum == found
    ending = index
    break
  end
end

puts actual[starting..ending].min + actual[starting..ending].max
