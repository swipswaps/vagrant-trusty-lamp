#!/usr/bin/env bash

# install redis
apt-get -y install make

mkdir /opt/redis

cd /opt/redis
# Use latest stable
wget -q http://download.redis.io/redis-stable.tar.gz 2> /dev/null
# Only update newer files
tar -xz --keep-newer-files -f redis-stable.tar.gz

cd redis-stable
make
make install
rm /etc/redis.conf
mkdir -p /etc/redis
mkdir /var/redis
chmod -R 777 /var/redis
useradd redis

cp -u /etc/vagrant/redis/redis.conf /etc/redis/6379.conf
cp -u /etc/vagrant/redis/redis.init.d /etc/init.d/redis_6379

update-rc.d redis_6379 defaults

chmod a+x /etc/init.d/redis_6379
/etc/init.d/redis_6379 start
