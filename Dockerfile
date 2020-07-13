FROM archlinux:latest

MAINTAINER Fábio Roberto Teodoro <fr.teodoro@gmail.com>

ENV USER mpi_user
ENV HOME /home/${USER}

RUN pacman --noconfirm -Sy openmpi openssh
RUN ssh-keygen -A
RUN useradd ${USER} \
    && mkdir -p ${HOME}/.ssh

COPY ssh-keys/id_rsa.mpi ${HOME}/.ssh/id_rsa
COPY ssh-keys/id_rsa.mpi.pub ${HOME}/.ssh/authorized_keys
COPY ssh-keys/config ${HOME}/.ssh/config

WORKDIR ${HOME}
RUN  chown -R ${USER}:${USER} ${HOME} \
    && chmod 700 .ssh \
    && chmod 600 .ssh/*

EXPOSE 22
ENTRYPOINT ["/usr/bin/sshd"]
CMD ["-D"]
