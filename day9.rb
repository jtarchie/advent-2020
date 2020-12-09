# frozen_string_literal: true

actual = File.readlines('day9.txt').map(&:to_i)
preamble = 25

(preamble..actual.length).step(1).each do |index|
  combinations = actual[index - preamble...index].combination(2)
  calculated_sums = combinations.map(&:sum)
  unless calculated_sums.include?(actual[index])
    puts actual[index]
    break
  end
end
