class Validators::QuestionValidator < ActiveModel::Validator
  def validate(record)
    %w(title content).each_with_index do |collomn, index|
      record.errors[:base] << "#{index+1}. #{collomn.capitalize} "   \
                              "field can not be blank; " if record.send(collomn.to_sym).blank?
    end
  end
end