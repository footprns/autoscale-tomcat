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
    

