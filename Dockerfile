FROM ubuntu:20.10
LABEL maintainer="matiaet98"
LABEL version="1.0.0"

ARG DEBIAN_FRONTEND=noninteractive

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV SPARK_HOME=/spark
ENV SPARK_CONF_DIR=/spark

WORKDIR /

RUN apt update && \
    apt install -y openjdk-11-jdk openssh-server openssh-client && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean && \
    useradd -m -G users spark

RUN wget https://archive.apache.org/dist/spark/spark-3.0.0/spark-3.0.0-bin-hadoop3.2.tgz && \
    tar xfz spark-3.0.0-bin-hadoop3.2.tgz && \
    rm -fr spark-3.0.0-bin-hadoop3.2.tgz && \
    ln -s spark-3.0.0-bin-hadoop3.2 spark && \
    mkdir -p /spark/log && \
    mkdir -p /spark/run

RUN wget https://maven.xwiki.org/externals/com/oracle/jdbc/ojdbc8/12.2.0.1/ojdbc8-12.2.0.1.jar && \
    cp ojdbc8-12.2.0.1.jar /spark/jars/ojdbc8.jar && \
    rm -fr ojdbc8-12.2.0.1.jar && \
    mkdir -p /tmp/spark-events

COPY ./entrypoint.sh /
RUN chown -R spark:spark /spark

USER spark

WORKDIR /spark

EXPOSE 7077 18080 8080 4040 8081
ENTRYPOINT [ "/entrypoint.sh" ]

