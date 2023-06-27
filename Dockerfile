FROM debian:buster

ARG USER_ID
ARG GROUP_ID

RUN echo $USER_ID
RUN echo $GROUP_ID

RUN apt-get update &&\
    apt-get install -y \
        build-essential gawk gcc-multilib flex git gettext \
        libncurses5 libncurses5-dev zlib1g-dev curl libsnmp-dev \
        liblzma-dev sudo time git-core subversion g++ bash make \
        libssl-dev patch wget unzip xz-utils python python-distutils-extra \
        python3 python3-distutils python3-distutils-extra \
        python3-setuptools libpam0g-dev cpio rsync  && \
    apt-get clean


RUN addgroup --gid $USER_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

VOLUME ['/usr/local/src/custom_firmware/']
WORKDIR /usr/local/src/custom_firmware/

USER user

# set dummy git config
RUN git config --global --add safe.directory '*'