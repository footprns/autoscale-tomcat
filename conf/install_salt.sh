#!/bin/bash
sudo yum -y install https://repo.saltstack.com/py3/amazon/salt-py3-amzn2-repo-latest.amzn2.noarch.rpm
sudo yum -y clean expire-cache
sudo yum -y install salt-minion
sudo yum -y install git
sudo mkdir /srv/salt
sudo git clone https://github.com/saltstack-formulas/tomcat-formula.git /srv/salt
sudo salt-call --local state.sls tomcat --file-root=/srv/salt
sudo curl -sSk https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war -o /usr/share/tomcat/webapps/sample.war