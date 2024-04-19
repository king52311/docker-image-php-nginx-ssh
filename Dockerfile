FROM jetsung/nginx-php:8.1
MAINTAINER  king52311@126.com
#  docker build   --no-cache --rm -t king52311/nginx-php-ssh:8.1 .
RUN apt-get update && apt-get install -y cron vim autoconf  build-essential openssh-server
COPY imagick.sh  /tmp/imagick.sh
COPY ssh_root.conf  /etc/ssh/sshd_config.d/ssh_root.conf
COPY authorized_keys /root/.ssh/authorized_keys
RUN chmod a+x /tmp/imagick.sh
RUN  /tmp/imagick.sh
RUN  service ssh start
COPY cron.conf /etc/supervisor/conf.d/cron.conf
COPY sshd.conf /etc/supervisor/conf.d/sshd.conf
COPY localtime /etc/localtime
RUN touch /var/log/cron.log
