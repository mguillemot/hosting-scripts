#
# Backup & upload script.
# (based on the shell script backup.sh written on September 16, 2009)
#
# Author: Matthieu Guillemot 
# Created: November 21, 2009
# 1st revision: October 5, 2011
#

# Note: a backup-config.rb file should be defined for this precise server purposes.
require 'backup-config'

require 'date'
require 'net/ftp'

def echo(line)
  puts "#{DateTime.now} #{line}"
end

def mysql_credentials
  credentials  = ""
  credentials += " --user=#{MYSQL_SETTINGS[:user]}" if MYSQL_SETTINGS[:user]
  credentials += " --password=#{MYSQL_SETTINGS[:password]}" if MYSQL_SETTINGS[:password]
  credentials
end

puts "----------------------------------------------------------------------------"
File.umask 0077 # Do not let any other user see our files
Dir.chdir BACKUP_HOME

if BACKUP_MYSQL
  echo "Starting MySQL backup..."
  Kernel.` "mysqldump --all-databases #{mysql_credentials} | gzip > #{BACKUP_HOME}/backup-mysql-#{DateTime.now}.sql.gz"
  echo "MySQL dump complete."
end

BACKUP_DIR.each do |dir|
  echo "Starting #{dir[:name]} backup (#{dir[:path]})..."
  Dir.chdir dir[:path]
  exclude = (dir[:exclude] || []).inject("") { |cmd,pattern| "#{cmd}--exclude=#{pattern} " }
  Kernel.` "tar zcf #{BACKUP_HOME}/backup-#{dir[:name]}-#{DateTime.now}.tar.gz #{exclude} *"
  echo "Complete: #{dir[:name]}"
end

Dir.chdir BACKUP_HOME
if USE_FTP_BACKUP
  echo "Copying everything in backup ftp..."
  ftp = Net::FTP.open(FTP_SETTINGS[:host], FTP_SETTINGS[:user], FTP_SETTINGS[:password])
  Dir.glob('*.gz') do |file|
    begin
      echo "Uploding #{file} (size: #{File.size(file)})"
      ftp.putbinaryfile(file)
      echo "Deleting #{file}"
      File.unlink(file)
    rescue e
      echo "ERROR: #{e}"
    end
  end
  ftp.close
else
  echo "Skipping FTP backup."
  # Keep only 7 days worth of backup
  Kernel.` 'find -maxdepth 1 -name "*.gz" -mtime +7 -delete'
end

echo "All done!"