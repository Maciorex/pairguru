class TitleBracketsValidator < ActiveModel::Validator
  def validate(record)
    if record.title.blank?
      record.errors[:base] << "Title is blank"
    end
  end
end
