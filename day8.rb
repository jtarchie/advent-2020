# frozen_string_literal: true

class Instruction
  def initialize(type, value)
    @type = type
    @value = value
  end

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
    counter = 0

    until instructions[counter].executed?
      @accum, jump = instructions[counter].run!(@accum)
      counter += jump
    end
  end

  attr_reader :accum

  private

  def instructions
    @instructions ||= begin
      lines = File.readlines(@filename)
      lines.map do |line|
        scanned = line.scan(/(\w+) ([+-]\d+)/).flatten
        type = scanned[0]
        value = scanned[1].to_i
        Instruction.new(type, value)
      end
    end
  end
end

program = Instructions.new('day8.txt')
program.run!

puts program.accum
