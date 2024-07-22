FROM debian:bullseye

RUN apt-get update && apt-get install -y redis

RUN sed -i "s|bind 127.0.0.1|bind 0.0.0.0|g" /etc/redis/redis.conf && \
    sed -i "s|# maxmemory <bytes>|maxmemory 20mb|g" /etc/redis/redis.conf && \
    echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf

COPY requirements/bonus/redis/conf/launch_redis.sh .

#RUN chmod +x launch_redis.sh && bash launch_redis.sh

EXPOSE 6379

CMD ["echo","hola"]
