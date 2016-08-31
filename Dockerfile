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
    wget \
    openssh-server \
    apache2 \
    mysql-client \
    iputils-ping


ENV ANT_VERSION 1.9.7

RUN cd tmp && \
    wget -q http://archive.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    tar -xzf apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mv apache-ant-${ANT_VERSION} /opt/ant && \
    rm apache-ant-${ANT_VERSION}-bin.tar.gz
ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:/opt/ant/bin

#Mount local dir context for GATE download and setup files
COPY . /tmp

#Copy the GATE download to the image
#CP files to /tmp
RUN cp -a /tmp/trunk /trunk && \
    cp /tmp/build.properties /trunk && \
    #cp /tmp/install.properties /trunk && \
    cp /tmp/antinstall-config.xml /trunk/install
#more config needed here

#install from the local volume /tmp/trunk
#CMD ["ant", "-propertyfile", "/trunk/install.properties", "dist"]
RUN cd /trunk && ant -propertyfile install.properties dist
#Prep the installer using the custom antintall-config file
RUN cd / && java -jar /trunk/dist/install.jar text-auto
#Run installer
RUN cd /trunk && ant install

#Finally run the GATE service via tomcat
#RUN export /trunk/tomcat6
#CMD ["env","BASEDIR=/trunk/tomcat6"]
RUN ip -4 address
RUN cd /trunk/tomcat6/bin/ && chmod 775 catalina.sh && ./catalina.sh run
CMD ["/bin/bash"]
