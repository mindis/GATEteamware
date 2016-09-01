# NOT YET WORKING - not finished

Help gratefully received.

# Gate General Architecture Text Extraction - unofficial

GATE Teamware provides a collaborative platform for text processing to extract entities, relations and correference. [1] GATE Teamware is [hosted by sourceforge](https://sourceforge.net/p/gate/code/HEAD/tree/teamware/trunk/)

## Todo

- runninr `ant install` on container start seems to exit the container. An error on install quits the container. fix BASEDIR issue on start
- lockdown and secure
- migrate setup perams to docker-compose.yml

## Possible issues to investigate

1. openjdk-6-jre vs openjdk-8-jre

  - seems to build with openjdk-8

2. ANT_VERSION 1.9.7 vs the specified 1.8.4 (which didn't seem to build)

## General disclaimer / plea

This is my first attempt at a more complex docker build, so be nice! Comments & suggestions welcomed.

## Build process

### Prerequisites

- mysql
- Java 6 JDK
- ant version 1.8.x
- PERL
- wget
- Image from [mysql image](https://hub.docker.com/_/mysql/)

## Customise Install

- build and run the db first, it needs to be running for the app to finnish building. e.g. it needs to access the db.
- I'm using a lan apt-cache-ng server, so you need to remove the `RUN echo 'Acquire::http { Proxy "http://192.168.0.210:3142"; };' >> /etc/apt/apt.conf.d/01proxy` line
- Download gate from sourceforge and place the `trunk` folder in the same folder as the docker file. It gets loaded and copied to the image when it's built. I did this to stop me having to thrash my bw and the sourceforge servers every re-build!
- change default values to suite env in antinstall-config.xml
- mirror values in build.properties

## Licence

GATE Teamware is available under the [GNU Affero General Public Licence 3.0](http://www.gnu.org/licenses/agpl-3.0.html) so as I understand you are free to use the source, but must not sublicence without permission [2].

I'm trying to avoid the Oracle behemoth by using openjdk.

As for this docker file - do what you like. Let me know how you get on.

## This was build by..

Peter Coghill ([@petecog](https://twitter.com/petecog)) of [Aleph Insights](www.alephinsights.com)

[1]: https://gate.ac.uk/teamware/
[2]: https://tldrlegal.com/license/gnu-general-public-license-v3-(gpl-3)
