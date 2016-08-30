# NOT YET WORKING - this is not finished yet!

Help gratefully received.

--------------------------------------------------------------------------------

## Todo

- mysql setup and linkages
- mysql parameters in gate image
- build.properties perams

## Possible issues to investigate

1. openjdk-6-jre vs openjdk-8-jre
2. use of openjkd at all instead of the specified Oracle Java JDK - does it build properly?

# Gate General Architecture Text Extraction - unofficial

GATE Teamware provides a collaborative platform for text processing to extract entities, relations and coreference. [1]

GATE Teamwhere is [hosted by sourceforge](https://sourceforge.net/p/gate/code/HEAD/tree/teamware/trunk/)

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

- I'm using a lan apt-cache-ng server, so you need to remove the `RUN echo 'Acquire::http { Proxy "http://192.168.0.210:3142"; };' >> /etc/apt/apt.conf.d/01proxy` line
- Download gate from sourceforge and place the `trunk` folder in the same folder as the docker file. It gets loaded and copied to the image when it's built. I did this to stop me having to thrash my bw and the sourceforge servers every re-build!
- loads more setup to do for the MySQL db - todo!

## Licence

GATE Teamware is available under the [GNU Affero General Public Licence 3.0](http://www.gnu.org/licenses/agpl-3.0.html) so as I understand you are free to use the source, but must not sublicence without permission [2].

I'm trying to avoid the Oracle behemoth by using openjdk.

As for this docker file - do what you like. Let me know how you get on.

## This was build by..

Peter Coghill ([@petecog](https://twitter.com/petecog)) of [Aleph Insights](www.alephinsights.com)

[1]: https://gate.ac.uk/teamware/
[2]: https://tldrlegal.com/license/gnu-general-public-license-v3-(gpl-3)
