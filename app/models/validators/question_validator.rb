class Validators::QuestionValidator < ActiveModel::Validator
  def validate(record)
    %w(title content).each_with_index do |collomn, index|
      if record.send(collomn.to_sym).blank? || record.send(collomn.to_sym).nil? || record.send(collomn.to_sym).empty?
        record.errors[:base] << "#{index+1}. #{collomn.capitalize} field can not be blank; "
      end 
    end
  end
end