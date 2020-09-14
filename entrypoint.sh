#!/bin/bash

if [ -z $SPARK_MASTER_HOST ]
then
  SPARK_MASTER_HOST=$HOSTNAME
fi

if [ -z $SPARK_MASTER_PORT ]
then
  SPARK_MASTER_PORT=7077
fi

if [ "$ROLE" == "master" ]
then
  /spark/sbin/start-history-server.sh &> /dev/null &
  /spark/bin/spark-class org.apache.spark.deploy.master.Master >> /dev/stdout
 elif [ "$ROLE" == "slave" ]
then
  /spark/bin/spark-class org.apache.spark.deploy.worker.Worker spark://$SPARK_MASTER_HOST:$SPARK_MASTER_PORT >> /dev/stdout
else
  echo "You must specify a role for the container (master|slave)" 
  exit 1
fi

