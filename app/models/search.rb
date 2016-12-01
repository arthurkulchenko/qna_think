class Search < ActiveRecord::Base
  self.abstract_class = true
  
  def self.for(text, in_area)
    @result = 
              if in_area == "Global"
                ThinkingSphinx.search prepare(text), classes: [User, Question, Answer, Comment]
              else
                if ["User", "Question", "Answer", "Comment"].include?(in_area)
                  in_area.classify.safe_constantize.search self.prepare(text)
                end
              end
    @result.push content: "Nothing is found" if @result.empty?
    @result
  end
  
  private
    
    def self.prepare(text)
      %w(@ -).each { |s| text.gsub!(s, "\\"+s) if text.include?(s) }
      text
    end
end