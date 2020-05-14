create tomcat webapp configuration:
  file.managed:
    - name: /usr/share/tomcat/conf/Catalina/localhost/ROOT.xml
    - makedirs: True
    - contents: |
        <Context docBase="/opt/webapps/sample" path="" reloadable="true" />

create directory for application:
  file.directory:
    - name: /opt/webapps/sample

tomcat restart:
  service.running:
    - name: tomcat
    - watch:
        - file: create tomcat webapp configuration

download sample war file:
  file.managed:
    - name: /opt/webapps/sample.war
    - source: https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
    - skip_verify: True

    

