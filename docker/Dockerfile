# Basisimage
FROM debian:bullseye

# ARG ROOT_PASSWORD
# ENV ROOT_PASSWORD=$ROOT_PASSWORD

# ENV TZ=Europe/Berlin

# Installiere den SSH-Server und richte die Umgebung ein
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y vim curl dumb-init git
RUN apt-get install -y iproute2 html2text w3m net-tools iputils-ping

RUN apt-get install -y locales
# Generate the desired locale (de_DE.UTF-8)
RUN locale-gen en_US.UTF-8

# RUN apt-get install -y systemd
RUN apt-get install -y openssh-server && \
    mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#Port 22/# Workshop tipp: Neuen Port hier einfuegen und den vorherigen so lassen\nPort 22\n# Port <Dein Port>\n/' /etc/ssh/sshd_config

RUN --mount=type=secret,id=root_password \
    echo "root:$(cat /run/secrets/root_password)" | chpasswd

# Copy the script to /usr/local/sbin
COPY nft-update.sh /usr/local/sbin/
RUN chmod a+x /usr/local/sbin/nft-update.sh


# RUN mkdir -p /run/systemd /var/run/sshd
# VOLUME [ "/sys/fs/cgroup" ]
RUN service ssh start

# Expose den Standard-SSH-Port
EXPOSE 22
EXPOSE 443
EXPOSE 80

# https://stackoverflow.com/a/28406007
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && \
    locale-gen
# Set the environment variables
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Starte den SSH-Dienst
ENTRYPOINT ["/usr/bin/dumb-init","--"]
CMD ["/usr/sbin/sshd", "-D"]
# CMD ["/lib/systemd/systemd"]
# CMD ["/usr/sbin/init"]
