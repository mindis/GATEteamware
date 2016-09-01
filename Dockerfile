#FROM brandonstevens/ant
FROM frekele/ant:1.9.7-jdk8


RUN  echo 'Acquire::http { Proxy "http://192.168.0.210:3142"; };' >> /etc/apt/apt.conf.d/01proxy

RUN apt-get update && \
    apt-get install -y \
    #mysql-client \
    iputils-ping

COPY . /mnt

RUN cp -a /mnt/trunk /trunk && \
    cp /mnt/build.properties /trunk && \
    #cp /mnt/install.properties /trunk && \
    cp /mnt/antinstall-config.xml /trunk/install

RUN cd /trunk && ant -propertyfile install.properties dist
#Prep the installer using the custom antintall-config file
RUN cd / && java -jar /trunk/dist/install.jar text-auto
#Run installer
#RUN cd /trunk && ant install
#FAIL POINT - It's at this point that it fails if it can't find the DB

#RUN ip -4 address
#RUN cd /trunk/tomcat6/bin/ && chmod 775 catalina.sh && ./catalina.sh run

CMD ["/bin/bash"]
