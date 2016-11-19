module Parent
  
  extend ActiveSupport::Concern

  included do

    private

      def parent
        @parent ||= request.original_fullpath[/[\w]+/].classify.constantize.find(params["#{request.original_fullpath[/[\w]+/].singularize}".+('_id').to_sym])
      end

      def parent_question_id
        @question_id = parent.try(:question_id) || parent.id
      end
  end
	
end