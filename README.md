# Apache Spark 3 for Docker

This container if for creating an Apache Spark cluster using docker containers.
I created it for testing purposes on a Nomad cluster, don't use it on production environments.


### Start Spark Master

```bash
docker run \
  -d \
  --name myspark \
  -p 7077:7077 \
  -p 8080:8080 \
  -p 18080:18080 \
  -e ROLE=master \
  arquitectura/spark:3.0.0
```

### Start Spark Worker

```bash
docker run \
  -d \
  --name myspark2 \
  -p 8081:8081 \
  -e SPARK_MASTER_HOST=<master host or ip> \
  -e ROLE=slave \
  arquitectura/spark:3.0.0
```

Environment variables:

- SPARK_MASTER_HOST: Master ip address or hostname.
- SPARK_MASTER_PORT: Master port, defaults to 7077
- ROLE: master or slave

