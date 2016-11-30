require_relative '../acceptance_helper'

feature "searching", %q(
  In order to find some question
  As guest
  I whant to search it  
  )do
    given!(:subject){ create(:question }
    given!(:attribute){ :content }
    it_behaves_like 'SerchingWithSphinx'
end