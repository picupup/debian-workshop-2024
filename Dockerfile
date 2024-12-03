# Basisimage
FROM debian:bullseye

# ARG ROOT_PASSWORD
# ENV ROOT_PASSWORD=$ROOT_PASSWORD

# ENV TZ=Europe/Berlin

# Installiere den SSH-Server und richte die Umgebung ein
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y vim curl dumb-init git
RUN apt-get install -y iproute2 html2text w3m net-tools
# RUN apt-get install -y systemd
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/Port 22\n# Workshop tipp: Neuen Port hier einfuegen und den vorherigen so lassen\n/' /etc/ssh/sshd_config

RUN --mount=type=secret,id=root_password \
    echo "root:$(cat /run/secrets/root_password)" | chpasswd

# RUN apt-get install -y tzdata && \
#    ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
#    dpkg-reconfigure -f noninteractive tzdata

# Create necessary directories for systemd
# RUN mkdir -p /run/systemd /var/run/sshd
# VOLUME [ "/sys/fs/cgroup" ]

# Expose den Standard-SSH-Port
EXPOSE 22
EXPOSE 443
EXPOSE 80


# ENV TERM=xterm

# Starte den SSH-Dienst
ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/usr/sbin/sshd", "-D"]
# CMD ["/lib/systemd/systemd"]
# CMD ["/usr/sbin/init"]
