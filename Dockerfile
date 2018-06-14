FROM ubuntu
MAINTAINER evocrash
RUN adduser --disabled-password --gecos '' user1
RUN usermod -aG sudo user1

RUN apt-get clean
RUN apt-get update
RUN apt-get install -qy git=1:2.7.4-0ubuntu1.3
RUN apt-get install -qy python=2.7.12-1~16.04
RUN apt-get install -qy openjdk-8-jdk=8u151-b12-0ubuntu0.16.04.2
RUN apt-get install -qy r-base 3.2.3-4
COPY **/ /home/user1/
RUN chmod -R 777 /home/user1/**/

USER user1
WORKDIR /home/user1/
