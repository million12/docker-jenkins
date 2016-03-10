FROM jenkins:1.642.2
MAINTAINER Przemyslaw Ozgo linux@ozgo.info

USER root

COPY container-files/ /

RUN \
  apt-get update && \
  apt-get install -y sudo apt-transport-https ca-certificates && \
  rm -rf /var/lib/apt/lists/* && \
  echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers && \
  /usr/local/bin/plugins.sh /var/jenkins_home/plugins.txt && \
  apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
  mv docker.list /etc/apt/sources.list.d/docker.list && \
  apt-get update && \
  apt-cache policy docker-engine && \
  apt-get install -y --fix-missing docker-engine=1.10.2-0~jessie && \
  apt-get clean all

EXPOSE 8080 50000
