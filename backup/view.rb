#
# View uploaded backups script.
#
# Author: Matthieu Guillemot
# Created: October 8, 2011
# Updated: January 21, 2012 (compute total size)
#

# Note: a backup_config.rb file should be defined for this precise server purposes.
$LOAD_PATH << "."
require 'backup_config'

require 'date'
require 'net/ftp'

if USE_FTP_BACKUP
  totalSize = 0
  puts "Backuped files are:"
  Net::FTP.open(FTP_SETTINGS[:host], FTP_SETTINGS[:user], FTP_SETTINGS[:password]) do |ftp|
    ftp.list.each do |listing|
      parts = listing.split(/\s+/)
      name = parts[-1]
      size = parts[4].to_i
      totalSize += size
      puts "  #{size/1024/1024} Mb     #{name}"
    end
  end
  puts "Total size was #{totalSize/1024/1024} Mb"
else
  puts "ERROR: Not configured for using FTP backup."
end
