# Backup Mysql on Glacier #

Use this repository to backup your mysql database on amazon glacier storage

### How to setup and run ###

* Clone the project 
~~~
   git clone https://bitbucket.org/atifsaddique/glacier_backup.git
~~~

* cd into the project

* edit the glacier-cmd.config file and specify your aws access and secret key and also specify the region of your glacier storage.

* edit the backup_glacier.py file and specify the mysql db login/username, db password, db host/ip, glacier vault name and your name as host name, also specify the database name in db_string variable.

* add rule for port 3306 and your ip in your host instance security group(specify the same/instance ip, if your are docker on same instance)

* build the docker image
~~~
sudo docker build -f Dockerfile --rm -t backup_mysql .
~~~

* run the docker container
~~~
sudo docker run --name backup_mysql -it backup_mysql
~~~

### Optional Steps ###
The backup is run as a cron job, and it runs daily by default.
you can change this setting in pliro_cron file.