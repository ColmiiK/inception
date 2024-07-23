FROM debian:bullseye

ARG FTP_USER
ARG FTP_PASS

RUN apt-get update && apt-get install -y \
    vsftpd

RUN mkdir -p /var/usr/vsftpd/empty

RUN  echo "${FTP_USER}:${FTP_PASS}" 

RUN adduser --home /var/www --shell /bin/false --disabled-password --gecos "" ${FTP_USER}
RUN echo "${FTP_USER}:${FTP_PASS}" | chpasswd
RUN usermod -aG root ${FTP_USER}

RUN sed -i "s|#chroot_local_user=YES|chroot_local_user=YES|g" /etc/vsftpd.conf \
 && sed -i "s|#local_enable=YES|local_enable=YES|g" /etc/vsftpd.conf \
 && sed -i "s|#write_enable=YES|write_enable=YES|g" /etc/vsftpd.conf \
 && sed -i "s|#local_umask=022|local_umask=007|g" /etc/vsftpd.conf

RUN echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf \
 && echo "seccomp_sandbox=NO" >> /etc/vsftpd.conf \
 && echo "pasv_enable=YES" >> /etc/vsftpd.conf \
 && echo "secure_chroot_dir=/var/usr/vsftpd/empty" >> /etc/vsftpd.conf 

WORKDIR /var/www

EXPOSE 21

CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
