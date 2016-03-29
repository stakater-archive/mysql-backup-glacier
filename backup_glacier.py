import sys
from datetime import datetime
import subprocess

DB_LOGIN = '*****'
DB_PASSWD = '*****'
DB_HOST = '*****'
VAULT_NAME = '*****'
HOSTNAME = '*****'

backup_string = 'backup.pliro.sql'
db_string = 'ams'
today = datetime.today()
date_string = '%s%s%s-%s%s%s' % (today.year, today.month, today.day, today.hour, today.minute, today.second)

def execute_cmd(cmd):
    cmd = ' '.join(cmd)
    print "Executing %s..." % (cmd)
    log.write("Executing %s..." % (cmd))
    ret = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    log.write(ret.stdout.read())
    print "Done."

with open('./log.txt', 'a+') as log:
    print "Working..."

    log.write('\n-------------- BACKUP START FOR %s----------------\n' % date_string)

    # MYSQL DUMP
    cmd = ['mysqldump', '-h%s'%DB_HOST, '-u%s'%DB_LOGIN, '-p%s'%DB_PASSWD, '--databases %s'%db_string,'--result-file=backup.pliro.sql']
    execute_cmd(cmd)

    # COMPRESS
    cmd = ["tar", 'cfz', '%s.tar.gz'%date_string, backup_string]
    execute_cmd(cmd)

    # SEND TO GLACIER
    cmd = ["glacier-cmd", 'upload', VAULT_NAME, '%s.tar.gz'%date_string, "--description='%s backup for %s'"%(HOSTNAME, date_string)]
    execute_cmd(cmd)

    # CLEAN
    execute_cmd(['mv', '%s.tar.gz'%date_string, 'last_backup.tar.gz'])
    execute_cmd(['rm', './backup.pliro.sql'])
