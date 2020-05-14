create tomcat webapp configuration:
  file.managed:
    - name: /usr/share/tomcat/conf/Catalina/localhost/ROOT.xml
    - makedirs: True
    - contents: |
        <Context docBase="/opt/webapps/sample" path="" reloadable="true" />

create directory for application:
  file.directory:
    - name: /opt/webapps/sample
    - makedirs: True

download sample war file:
  file.managed:
    - name: /opt/webapps/sample.war
    - source: https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war
    - skip_verify: True
    - mode: 755

extract war file:
  archive.extracted:
    - name: /opt/webapps/sample
    - source: /opt/webapps/sample.war

tomcat restart:
  service.running:
    - name: tomcat
    - watch:
        - archive: extract war file

