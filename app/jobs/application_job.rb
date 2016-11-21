class ApplicationJob < ActiveJob::Base
  # Sidekiq::Queue.all.each &:clear
end