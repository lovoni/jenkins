FROM jenkins/jenkins:2.76
MAINTAINER lbognini@gmail.com

ARG MAVEN_VERSION=3.5.0
# if we want to install via apt
USER root

# install maven
RUN wget --no-verbose -O /tmp/apache-maven.tar.gz http://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz
# verify checksum
RUN echo "35c39251d2af99b6624d40d801f6ff02 /tmp/apache-maven.tar.gz" | md5sum -c
RUN tar xzf /tmp/apache-maven.tar.gz -C /opt/ 			&& \
	ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
	ln -s /opt/maven/bin/mvn /usr/local/bin 			&& \
	rm -f /tmp/apache-maven.tar.gz

VOLUME ~/.m2/settings.xml
ENV MAVEN_HOME /opt/maven

# drop back to the regular jenkins user - good practice
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER jenkins
