#
# Backup config file.
#

# NOTE: THIS IS A SAMPLE FILE, FOR REFERENCE ONLY!

BACKUP_HOME    = "/home/backup"

BACKUP_MYSQL   = false
MYSQL_SETTINGS =
    {
        :user => "root",
        :password => nil
    }

BACKUP_DIR =
    [
        {
            :name => "home",
            :path => "/home",
            :exclude => []
        }
    ]

USE_FTP_BACKUP = false
FTP_SETTINGS =
    {
        :host => "",
        :user => "",
        :password => ""
    }
