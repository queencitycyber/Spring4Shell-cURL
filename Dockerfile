FROM tomcat:9.0
MAINTAINER sprocketsecurity
COPY ./stupidRumor_war.war /usr/local/tomcat/webapps/
