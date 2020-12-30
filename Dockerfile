FROM maven:3-jdk-6
# build arguments
ARG ANT=./src/apache-ant-1.8.4
ARG LUCENE=./src/lucene-solr
# move source code into container
ADD $ANT /code/ant
ADD $LUCENE /code/lucene
# setup build environment
ENV JAVA_HOME=/usr/lib/jvm/java-1.6.0-openjdk-amd64
ENV ANT_HOME=/code/ant
ENV PATH=$PATH:$ANT_HOME/bin
ENV CLASSPATH=/code/class
# initial source code build
WORKDIR /code/lucene
ADD build.sh /bin
RUN build.sh
CMD bash
