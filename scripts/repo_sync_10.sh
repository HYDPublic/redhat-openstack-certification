#!/bin/bash

# Ensure these packages are installed:
# yum install -y createrepo yum-utils

DATE_SYNCHRO="20170821-10"

REPO_LIST="rhel-7-server-openstack-10-rpms rhel-7-server-rpms rhel-7-server-extras-rpms rhel-7-server-rh-common-rpms rhel-7-server-satellite-tools-6.2-rpms rhel-ha-for-rhel-7-server-rpms rhel-7-server-rhceph-2-osd-rpms rhel-7-server-rhceph-2-mon-rpms rhel-7-server-openstack-10-devtools-rpms rhel-7-server-cert-rpms"

REPO_FOLDER="/var/www/html/$DATE_SYNCHRO"
REPO_CONF="$REPO_FOLDER/local.repo"
REPO_FILE="$REPO_FOLDER/local_file.repo"
REPO_URL="http://10.210.8.39/$DATE_SYNCHRO"
REPO_PATH="file:///var/www/html/$DATE_SYNCHRO"

mkdir -p $REPO_FOLDER
/bin/rm -f $REPO_CONF
/bin/rm -f $REPO_FILE
for REPO in $REPO_LIST
do
  echo "Sync of $REPO"
  #reposync -l -n -d --repoid=$REPO --download_path=$REPO_FOLDER
  mkdir -p $REPO_FOLDER/$REPO
  cd $REPO_FOLDER/$REPO
  #createrepo .

  cat >>$REPO_CONF<< EOF
[$REPO]
name=$REPO
baseurl=$REPO_URL/$REPO/
enabled=1
gpgcheck=0
EOF

  cat >>$REPO_FILE<< EOF
[$REPO]
name=$REPO
baseurl=$REPO_PATH/$REPO/
enabled=1
gpgcheck=0
EOF


done

restorecon -Rv REPO_FOLDER/$REPO/
chcon -R system_u:object_r:httpd_sys_content_t:s0 REPO_FOLDER/$REPO/
