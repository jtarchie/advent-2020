PasswordCheck = Struct.new(:range, :letter, :password, keyword_init: true) do
  def valid?
    range.include?(password.scan(letter).count)
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