FROM debian:bullseye

RUN apt-get update && apt-get install -y redis

COPY requirements/bonus/redis/conf/redis.conf /etc/redis/redis.conf

RUN sed -i "s|bind 127.0.0.1|bind 0.0.0.0|g" /etc/redis/redis.conf \
    && sed -i "s|# maxmemory <bytes>|maxmemory 20mb|g" /etc/redis/redis.conf \
    && echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf

EXPOSE 6379

CMD ["redis-server", "/etc/redis/redis.conf"]
