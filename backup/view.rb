#
# View uploaded backups script.
#
# Author: Matthieu Guillemot 
# Created: October 8, 2011
#

# Note: a backup_config.rb file should be defined for this precise server purposes.
$LOAD_PATH << "."
require 'backup_config'

require 'date'
require 'net/ftp'

if USE_FTP_BACKUP
  puts "Backuped files are:"
  Net::FTP.open(FTP_SETTINGS[:host], FTP_SETTINGS[:user], FTP_SETTINGS[:password]) do |ftp|
    ftp.nlst.each do |file| 
      puts "  #{file}"
    end
  end
else
  puts "ERROR: Not configured for using FTP backup."
end
