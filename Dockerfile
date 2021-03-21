FROM alpine:latest

RUN apk add --update --no-cache \
	openssh      \
        rsync

COPY aliases.sh /etc/profile.d/
# following line causes non-login shells to source
#  /etc/profile, which loads the above aliases.sh
ENV ENV="/etc/profile"

RUN  echo "Syncer Image" >> /notes

RUN mkdir -p --mode 0700 /root/.ssh
COPY key.pub /root/.ssh/authorized_keys
RUN chmod 0600 /root/.ssh/authorized_keys

RUN /usr/bin/ssh-keygen -A

RUN  echo "PasswordAuthentication yes"        >> /etc/ssh/sshd_config \
 &&  echo "PermitRootLogin prohibit-password" >> /etc/ssh/sshd_config \
 &&  echo "Banner /etc/ssh/mybanner"          >> /etc/ssh/sshd_config \
 &&  echo "Greetings from Syncer"              > /etc/ssh/mybanner

EXPOSE 22

COPY start.sh /start.sh

CMD ["/start.sh"]



