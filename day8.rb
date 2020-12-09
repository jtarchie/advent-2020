# frozen_string_literal: true

class Instruction
  def initialize(type, value)
    @type = type
    @value = value
  end

  attr_reader :type, :value

  def run!(accum)
    @visited = true

    case @type
    when 'acc'
      accum += @value
      [accum, 1]
    when 'nop'
      [accum, 1]
    else
      [accum, @value]
    end
  end

  def executed?
    @visited
  end
end

class Instructions
  def initialize(filename)
    @filename = filename
    @accum = 0
  end

  def run!
    stack = [0]

    instructions = instructions_from_file(@filename)

    accum = 0
    until instructions[stack.last].executed?
      accum, jump = instructions[stack.last].run!(accum)
      stack << (stack.last + jump)
    end

    while offset = stack.pop
      new_instructions = instructions_from_file(@filename)

      new_instructions[offset] = case new_instructions[offset].type
                                 when 'jmp'
                                   Instruction.new('nop', 0)
                                 when 'nop'
                                   Instruction.new('jmp', new_instructions[offset].value)
                                 else
                                   new_instructions[offset]
                                 end

      counter = 0
      accum = 0

      loop do
        accum, jump = new_instructions[counter].run!(accum)
        if counter == new_instructions.length - 1
          @accum = accum
          break
        end
        counter += jump
        break if new_instructions[counter].executed?
      end
    end
  end

  attr_reader :accum

  private

  def instructions_from_file(filename)
    lines = File.readlines(filename)
    lines.map do |line|
      scanned = line.scan(/(\w+) ([+-]\d+)/).flatten
      type = scanned[0]
      value = scanned[1].to_i
      Instruction.new(type, value)
    end
  end
end

program = Instructions.new('day8.txt')
program.run!

puts program.accum
