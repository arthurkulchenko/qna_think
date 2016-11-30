require_relative '../acceptance_helper'

feature "searching", %q(
  In order to find some comment
  As guest
  I whant to search it  
  )do
    given!(:subject){ create(:comment) }
    given!(:attribute){ :content }
    it_behaves_like 'SerchingWithSphinx'
end