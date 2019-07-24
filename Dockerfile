#
# environment to develop NNI
#
FROM ubuntu:18.04

WORKDIR /root/

# expose port
EXPOSE 8080

RUN mkdir /DATA
RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install apt-utils
RUN apt-get -y install build-essential python3-pip git wget net-tools vim

# SSH access
RUN apt-get -y install openssh-server
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN service ssh restart

RUN if [ ! -d /root/.ssh ]; then mkdir /root/.ssh; chmod 700 /root/.ssh; fi
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# NNI source code
RUN cd /root/ && git clone https://github.com/h3dema/nni.git
RUN cd /root/nni && make install-dependencies && make -j4

RUN pip3 install ipython jupyter matplotlib seaborn natsort tables tensorflow keras

RUN cd /root/nni && make my-install

RUN git config --global user.email "henriquemoura@hotmail.com"
RUN git config --global user.name "h3dema"

# note for myself:
# in casa-desktop computer, the current tensorflow does not work
# so downgrade it to 1.5, using:
#
# pip3 install tensorflow==1.5

# hack to have ssh server running
ENTRYPOINT service ssh start && bash
