require_relative '../acceptance_helper'

feature "searching", %q(
  In order to find some user
  As guest
  I whant to search it  
  )do
    given!(:subject){ create(:user) }
    given!(:attribute){ :email }
    it_behaves_like 'SerchingWithSphinx'
end