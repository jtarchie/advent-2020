PasswordCheck = Struct.new(:range, :letter, :password, keyword_init: true) do
  def valid?
    [range.min-1, range.max-1].select do |index|
      password[index] == letter
    end.size == 1
  end
end

lines = File.read('day2.txt').split("\n")
checks = lines.map do |line|
  range, letter, password = line.split(' ')
  
  low, high = range.split('-').map(&:to_i)

  PasswordCheck.new(
    range: low..high,
    letter: letter[0],
    password: password,
  )
end

puts checks.select(&:valid?).size