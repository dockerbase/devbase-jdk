# VERSION 1.0
# DOCKER-VERSION  1.2.0
# AUTHOR:         Richard Lee <lifuzu@gmail.com>
# DESCRIPTION:    Devbase-jdk Image Container

FROM dockerbase/devbase

MAINTAINER Richad Lee "lifuzu@gmail.com"

ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# Information Of Package
ENV	PKG_VERSION jdk1.8.0_20
ENV	PKG_PACKAGE jdk-8u20-linux-x64.tar.gz
ENV	PKG_LINK http://download.oracle.com/otn-pub/java/jdk/8u20-b26/$PKG_PACKAGE

# Java
RUN     cd /tmp && \
        curl -b gpw_e24=http%3A%2F%2Fwww.oracle.com -b oraclelicense=accept-securebackup-cookie -O -L $PKG_LINK && \
        tar -zxf /tmp/$PKG_PACKAGE -C /usr/local && \
        ln -s /usr/local/$PKG_VERSION /usr/local/java

ENV     JAVA_HOME /usr/local/java
ENV     JRE_HOME /usr/local/java/jre
ENV     PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin

# Run the build scripts
RUN     apt-get update

RUN     apt-get install -y --no-install-recommends libssl-dev man

# Clean up system
RUN     apt-get clean
RUN     rm -rf /tmp/* /var/tmp/*

USER    devbase

# Set environment variables.
ENV     HOME /home/devbase

# Define working directory.
WORKDIR /home/devbase

# Modify .bashrc
ENV     echo "export JAVA_HOME=$JAVA_HOME" >> $HOME/.bashrc
ENV     echo "export JRE_HOME=$JRE_HOME" >> $HOME/.bashrc
ENV     echo 'export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin' >> $HOME/.bashrc

# Define default command.
CMD ["bash"]
