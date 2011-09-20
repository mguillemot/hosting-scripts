#!/usr/bin/ruby

#
# Backup & upload script.
# (based on the shell script backup.sh written on September 16, 2009)
#
# Author: Matthieu Guillemot 
# Created: November 21, 2009
#

# Config:
BACKUP_HOME    = "/home/backup"
MYSQL_USER     = "root"
MYSQL_PWD      = "xxx"
USE_FTP_BACKUP = true
FTP_HOST       = "ftpback-rbx3-248.ovh.net"
FTP_USER       = "ns356869.ovh.net"
FTP_PWD        = "36EWVPzy8"

require 'date'
require 'net/ftp'

def echo(line)
  puts "#{DateTime.now} #{line}"
end

puts "----------------------------------------------------------------------------"

echo "Starting MySQL backup..."
Dir.chdir BACKUP_HOME
Kernel.` "mysqldump --all-databases -u #{MYSQL_USER} -p#{MYSQL_PWD} | gzip > #{BACKUP_HOME}/backup-mysql-#{DateTime.now}.sql.gz"
echo "MySQL dump complete."

echo "Starting www backup..."
Dir.chdir "/home"
Kernel.` "tar zcf #{BACKUP_HOME}/backup-www-#{DateTime.now}.tar.gz www"
echo "www backup complete."

echo "Starting ftp backup..."
Dir.chdir "/home"
Kernel.` "tar zcf #{BACKUP_HOME}/backup-ftp-#{DateTime.now}.tar.gz ftp"
echo "ftp backup complete."

if USE_FTP_BACKUP
  echo "Copying everything in OVH backup ftp..."
  ftp = Net::FTP.open(FTP_HOST, FTP_USER, FTP_PASS)
  Dir.chdir BACKUP_HOME
  Dir.glob('*.gz') do |file|
    echo "Uploding #{file} (size: #{File.size(file)})"
    ftp.putbinaryfile(file)
    echo "Deleting #{file}"
    File.unlink(file)
  end
  ftp.close
else
  echo "Skipping FTP backup."
  # Keep only 7 days worth of backup
  Kernel.` 'find -maxdepth 1 -name "*.gz" -mtime +7 -delete'
end

echo "All done!"