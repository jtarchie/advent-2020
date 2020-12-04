# frozen_string_literal: true

lines = File.read('day4.txt').split("\n\n")
valid_passports = lines.select do |line|
  matches = line.scan(/(\w+):/).flatten
  matches.size == 8 || matches.size == 7 && !matches.include?('cid')
end

puts valid_passports.size
