require_relative '../acceptance_helper'

feature "searching", %q(
  In order to find something i remember
  As guest
  I whant to search it  
  )do
    given!(:subject){ create(:answer) }
    given!(:attribute){ :content }
    it_behaves_like 'SerchingWithSphinx'
end