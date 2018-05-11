class TitleBracketsValidator < ActiveModel::Validator

  def validate(record)
    stack = []
    lookup = { '(' => ')', '[' => ']', '{' => '}' }
    left = lookup.keys
    right = lookup.values
    brackets = %w[ () [] {} ]

    record.title.each_char do |char|
      if left.include? char
        stack << char
      elsif right.include? char
        if stack.empty? || (lookup[stack.pop] != char)
          return record.errors[:base] << "There is something wrong with brackets"
        end
      end
    end
    
    unless stack.empty?
      return record.errors[:base] << "There is something wrong with brackets"
    end

    unless brackets.none? { |br| record.title.include?(br) }
      return record.errors[:base] << "Brackets are empty"
    end
  end
end
