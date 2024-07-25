FROM debian:bullseye

ARG FTP_USER \
    FTP_PASS

RUN apt-get update
RUN apt-get install -y \
    vsftpd
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


RUN mkdir -p /var/run/vsftpd/empty \
 && chown root:root /var/run/vsftpd/empty \
 && chmod 755 /var/run/vsftpd/empty

COPY requirements/bonus/vsftpd/conf/vsftpd.conf /etc/vsftpd.conf
COPY requirements/bonus/vsftpd/conf/vsftpd_create.sh /tmp/vsftpd_create.sh

CMD ["sh", "/tmp/vsftpd_create.sh"]
