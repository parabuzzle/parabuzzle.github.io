#!/bin/env ruby

require 'thread'

# Set the process name
$0 = 'jekyll_dev'

# Environment
ENV['JEKYLL_SKIP_SOCIAL'] ||= 'false'
ENV['JEKYLL_SKIP_DISQUS'] ||= 'true'
ENV['JEKYLL_WITH_DRAFTS'] ||= 'true'

# Commands to run
start_server = 'jekyll server'
start_builder = 'jekyll build --watch --drafts'
start_builder_no_drafts = 'jekyll build --watch'

# Setup
threads = []
shutdown = false

# Run the threads
puts 'starting server on port 4000'
threads << Thread.new { `#{start_server}` }
sleep 1
if ENV['JEKYLL_WITH_DRAFTS'] == 'true'
	puts 'starting builder with drafts enabled'
	threads << Thread.new { `#{start_builder}` }
else
	puts 'starting builder without drafts enabled'
	threads << Thread.new { `#{start_builder_no_drafts}` }
end

# Signal Handling
Signal.trap("TERM") { shutdown = true }
Signal.trap("KILL") { shutdown = true }
Signal.trap("INT")  { shutdown = true }

# Main Loop
while shutdown != true do
	sleep 0.2
end

puts '...shutting down'

# If we break out of the main loop.. we kill the threads
threads.each do |thread|
	Thread.kill(thread)
end

# Ensure that all threads are stopped properly
threads.each do |thread|
	unless thread
		while thread.status.match(/run|sleep/)
			Thread.kill(thread)
			sleep 0.1
		end
	end
end

