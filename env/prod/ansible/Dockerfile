FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y python3 python3-pip ssh && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install ansible

COPY ../.key_pair/botapeer-prod-server.id_rsa /root/.ssh/id_rsa

RUN chmod 600 /root/.ssh/id_rsa

COPY hosts /etc/ansible/hosts

WORKDIR /ansible

CMD ["ansible-playbook", "playbook.yml"]