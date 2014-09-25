# VERSION 1.1
# DOCKER-VERSION  1.2.0
# AUTHOR:         Richard Lee <lifuzu@gmail.com>
# DESCRIPTION:    Devbase-jdk Image Container

FROM dockerbase/devbase

# Run dockerbase script
ADD     java.sh /dockerbase/
RUN     /dockerbase/java.sh

ENV     JAVA_HOME /usr/local/java
ENV     JRE_HOME /usr/local/java/jre
ENV     PATH $PATH:$JAVA_HOME/bin:$JRE_HOME/bin

# Run dockerbase script
ADD     devbase-jdk.sh /dockerbase/
RUN     /dockerbase/devbase-jdk.sh

USER    devbase

# Set environment variables.
ENV     HOME /home/devbase

# Define working directory.
WORKDIR /home/devbase
