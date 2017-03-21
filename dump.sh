#!/bin/sh
#----------------------------------------------------
# a simple mysql database backup script.
# copyright 2017 SkydGit, https://github.com/SkydGit/
#----------------------------------------------------

# Backup directory
DIRDUMPSQL='/home/dumpsql/'

# (1) set up all the mysqldump variables
FILE=<name>.`date +"%Y%m%d"`.sql
DBSERVER=127.0.0.1
DATABASE=<name>
USER=<user>
PASS='<password>'

# (2) in case you run this more than once a day, remove the previous version of the file
unalias rm     2> /dev/null
rm ${FILE}     2> /dev/null
rm ${FILE}.gz  2> /dev/null

# (3) do the mysql database backup (dump)
# use this command for a database server on a separate host:
# mysqldump --opt --protocol=TCP --user=${USER} --password=${PASS} --host=${DBSERVER} ${DATABASE} > ${DIRDUMPSQL}${FILE}

# use this command for a database server on localhost. add other options if need be.
mysqldump --opt --user=${USER} --password=${PASS} ${DATABASE} > ${DIRDUMPSQL}${FILE}

# (4) gzip the mysql database dump file
gzip ${DIRDUMPSQL}$FILE

# (5) show the user the result
echo "${FILE}.gz was created:"
ls -l ${DIRDUMPSQL}${FILE}.gz
