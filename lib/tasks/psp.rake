require 'psp'

namespace :psp do
  desc 'Run all specs in parallel mode'
  task :all do
    tasks = Psp::PathResolver.new(
      plugins: Psp::PathResolver::DEFAULT_PATH_MASK,
      project: Psp::PathResolver::DEFAULT_PATH_MASK).expand

    succeed = Psp::Runner.new(tasks, concurrency: ENV.fetch('JOBS', 5), verbose: !!ENV.fetch('VERBOSE', false)).run
    exit_code = succeed ? 0 : 101

    puts "Total exit code: #{exit_code}"
    exit(exit_code)
  end
end
