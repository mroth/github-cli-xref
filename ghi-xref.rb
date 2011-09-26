#!/usr/bin/env ruby
require 'rubygems'
require 'choice'
require 'colored'

$VERBOSE = nil #disable warnings, since choice gem throws some deprecation warnings in ruby 1.9 (yes this is dirty)

Choice.options do
  option :msg do
    short '-m'
    long '--msg'
    desc "Optional message string that will appended to the comment describing the cross-reference."
  end
  option :source, :required => true do
    short '-s'
    long '--src'
    validate '(.+\/.+)\#(\d+)'
    desc "The source issue you wish to cross-reference elsewhere."
  end
  option :targets, :required => true do
    short '-t'
    long '--target *TARGETS'
    desc "The target issue(s) you with to cross-reference the source with."
  end
end

# parse CLI options
source = Choice.choices.source
targets = Choice.choices.targets
msg = Choice.choices.msg
msg = msg.nil? ? "" : " " + msg

#format GFM to structured data
source =~ /(.+\/.+)\#(\d+)/
source_repo = $1
source_issue = $2

targets.each do |target|
  target =~ /(.+\/.+)\#(\d+)/
  target_repo = $1
  target_issue = $2
  
  puts "Linking #{source_repo.green} issue #{"#".red + source_issue.red} to #{target_repo.green} issue #{"#".red + target_issue.red}"
  
  source_cmd = "ghi -r #{source_repo} comment #{source_issue} -m \"<i>Cross referencing this issue with #{target}.#{msg}</i>\""
  puts "   -> " + source_cmd.white
  system(source_cmd)
  
  target_cmd = "ghi -r #{target_repo} comment #{target_issue} -m \"<i>Cross referencing this issue with #{source}.#{msg}</i>\""
  puts "   -> " + target_cmd.white
  system(target_cmd)
end