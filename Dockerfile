FROM ubuntu:latest
MAINTAINER peter@alephinsights.com

#Delete this line, or update to point to your apt-cache-ng server.
RUN  echo 'Acquire::http { Proxy "http://192.168.0.210:3142"; };' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update \
    && \
    apt-get install -y \
    #software-properties-common \
    #subversion \  # these are needed if you want to SVN gate from the repository
    #libapache2-svn \
    default-jdk \
    # had to use this as I openjdk-6-jre dosnt seem to have tools.jar
    #openjdk-6-jre \
    perl \
    wget

ENV ANT_VERSION 1.8.4
RUN cd tmp && \
    wget -q http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mv apache-ant-${ANT_VERSION} /opt/ant && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz
ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:/opt/ant/bin

#Mount local dir context for GATE download and setup files
ADD . /tmp
#Copy the GATE download to the image
RUN cp -a /tmp/trunk /trunk

#More sql setup stuff to go here

RUN cp /tmp/build.properties /trunk
#more config needed here

#install from the local volume /tmp/trunk
RUN cd trunk && ant install

#Finally run the GATE service via tomcat
EXPOSE      8080
RUN ip -4 address
RUN cd /trunk/tomcat6/bin/ && ./catalina.sh run


CMD ["/bin/bash"]
