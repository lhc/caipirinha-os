FROM docker.io/debian:stable-slim

ARG USER_ID
ARG GROUP_ID

RUN echo $USER_ID
RUN echo $GROUP_ID

RUN apt-get update && apt-get install --no-install-recommends --no-install-suggests --yes \
    'build-essential' \
    'ca-certificates' \
    'clang' \
    'flex' \
    'bison' \
    'g++' \
    'gawk' \
    'gcc-multilib' \
    'g++-multilib' \
    'gettext' \
    'git' \
    'libncurses5-dev' \
    'libssl-dev' \
    'python3-distutils' \
    'rsync' \
    'unzip' \
    'zlib1g-dev' \
    'file' \
    'wget' \
    'curl' \
    'quilt' \
    'nano' \
  && \
  rm -f -r '/var/lib/apt/' && \
  rm -f -r '/var/cache/apt/' 


RUN addgroup --gid $USER_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

VOLUME ["/usr/local/src/custom_firmware/"]
WORKDIR /usr/local/src/custom_firmware/

USER user

# set dummy git config
RUN git config --global --add safe.directory '*'