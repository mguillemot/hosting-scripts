#!/usr/bin/ruby

KEEP_DAYS = 30 # delete archives that are older than 30 days

require 'date'

puts "Checking expired tarsnap backups..."
archives = `/usr/local/bin/tarsnap --list-archives`
archives = archives.split("\n").sort.map { |archive| archive.split("-") }
puts "Found TOTAL #{archives.length} backups"
projects = archives.group_by { |archive| archive[0] }
deleted = 0
projects.each do |project, project_archives|
  puts "Project #{project} has #{project_archives.length} backups"
  if project_archives.length > 1
    project_archives.each do |project_archive|
      d = "#{project_archive[1]}-#{project_archive[2]}"
      project_archive_date = DateTime.strptime(d, '%Y%m%d-%H%M%S')
      archive_name = "#{project_archive[0]}-#{project_archive[1]}-#{project_archive[2]}"
      delta_days = (DateTime.now - project_archive_date).to_f
      if delta_days > KEEP_DAYS
        puts "  Deleting #{archive_name} since it is #{delta_days} days old..."
        `tarsnap -d -f #{archive_name}`
        deleted += 1
      else
        puts "  Keeping #{archive_name} since it is only #{delta_days} days old"
      end
    end
  else
    puts "  Do not delete the unique archive"
  end
end
puts "TOTAL #{deleted} backups deleted"
