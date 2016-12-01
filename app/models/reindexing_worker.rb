require 'rake'
class ReindexingWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  recurrence { 15.minutes }
  def perform
    QaThinknetikaApp::Application.load_tasks
    Rake::Task['ts:rebuild'].invoke
  end
end