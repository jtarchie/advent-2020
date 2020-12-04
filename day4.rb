# frozen_string_literal: true

lines = File.read('day4.txt').split("\n\n")
valid_passports = lines.select do |line|
  matches = line.scan(/(\w+):([\w\#]+)/)
  passport = matches.to_h

  (passport.size == 8 || passport.size == 7 && !passport.key?('cid')) &&
    (1920..2002).include?(passport.fetch('byr').to_i) &&
    (2010..2020).include?(passport.fetch('iyr').to_i) &&
    (2020..2030).include?(passport.fetch('eyr').to_i) &&
    /^((1[5-8][0-9]|19[0-3])cm|(59|6[0-9]|7[0-6])in)$/.match?(passport.fetch('hgt')) &&
    /^#[a-f0-9]{6}$/.match?(passport.fetch('hcl')) &&
    %w[amb blu brn gry grn hzl oth].include?(passport.fetch('ecl')) &&
    /^\d{9}$/.match?(passport.fetch('pid'))
end

puts valid_passports.size
