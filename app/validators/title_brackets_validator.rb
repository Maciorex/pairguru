class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    if record.title.blank?
      record.errors[:base] << "Title is blank"
    end

    stack  = []
    lookup = { '(' => ')', '[' => ']', '{' => '}' }
    left   = lookup.keys
    right  = lookup.values
    brackets = %w[ () [] {} ]

    record.title.each_char do |char|
      if left.include? char
        stack << char
      elsif right.include? char
        return record.errors[:base] << "There is something wrong with brackets" if stack.empty? || (lookup[stack.pop] != char)
      end
    end
    unless stack.empty?
      return record.errors[:base] << "There is something wrong with brackets"
    end

    unless  brackets.none? { |b| record.title.include?( b ) }
      return record.errors[:base] << "Brackets are empty"
    end
  end
end
