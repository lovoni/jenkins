FROM jenkins/jenkins:2.104
MAINTAINER lbognini@gmail.com

ARG MAVEN_VERSION=3.5.2
# if we want to install via apt
USER root

#Install Docker
COPY install-docker.sh /tmp/install-docker.sh
RUN chmod +x /tmp/install-docker.sh
RUN /tmp/install-docker.sh

# install maven
RUN wget --no-verbose -O /tmp/apache-maven.tar.gz http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz

RUN tar xzf /tmp/apache-maven.tar.gz -C /opt/ 			&& \
	ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
	ln -s /opt/maven/bin/mvn /usr/local/bin 			&& \
	rm -f /tmp/apache-maven.tar.gz

ENV MAVEN_HOME /opt/maven

COPY jq-linux-x86_64 $JENKINS_HOME/tools/ 
RUN chmod 555 $JENKINS_HOME/tools/jq-linux-x86_64


# drop back to the regular jenkins user - good practice
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER jenkins
