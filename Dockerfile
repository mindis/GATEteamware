#FROM brandonstevens/ant
FROM frekele/ant:1.9.7-jdk8

RUN  echo 'Acquire::http { Proxy "http://192.168.0.210:3142"; };' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && \
    apt-get install -y \
    #mysql-client \
    iputils-ping

COPY . /mnt

RUN cp /mnt/build.properties /mnt/trunk && \
    cp /mnt/antinstall-config.xml /mnt/trunk/install

RUN cd /mnt/trunk && ant -propertyfile install.properties dist
#Prep the installer using the custom antintall-config file
RUN cd / && java -jar /mnt/trunk/dist/install.jar text-auto
#Run installer
RUN cd /mnt/trunk && ant install

#RUN ip -4 address
#RUN cd /trunk/tomcat6/bin/ && chmod 775 catalina.sh && ./catalina.sh run
#FAIL POINT - "BASEDIR environment variable is not defined correctly"
CMD ["/bin/bash"]
