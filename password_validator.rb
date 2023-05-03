class PasswordValidator
  def initialize(filename)
    @filename = filename
  end

  def count_valid_passwords
    valid_passwords = 0

    File.foreach(@filename) do |line|
      condition, password = line.strip.split(': ')
      next if condition.nil? || password.nil?

      char, range = condition.split(' ')
      min, max = range.split('-').map(&:to_i)

      if min >= 1 && max >= 1
        char_count = password.count(char)

        valid_passwords += 1 if char_count.between?(min, max)
      end
    end

    valid_passwords
  end
end

puts PasswordValidator.new("test.txt").count_valid_passwords