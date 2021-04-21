FROM ubuntu:20.04

RUN export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    make \
    fakeroot \
    perl \
    libtinfo5 \
    zstd \
    sudo \
    libedit-dev \
    binutils \
    git \
    libc6-dev \
    libcurl4 \
    libedit2 \
    libgcc-9-dev \
    libpython2.7 \
    libsqlite3-0 \
    libstdc++-9-dev \
    libxml2 \
    pkg-config \
    tzdata \
    zlib1g-dev \
    libz3-dev \
    openssh-client \
    nano \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' me \
    && usermod -aG sudo me \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR /home/me
USER me

ADD --chown=me:me \
    https://github.com/kabiroberai/swift-toolchain-linux/releases/download/v2.0.0/swift-5.3.2-ubuntu20.04.tar.xz \
    toolchain.tar.xz
RUN mkdir -p theos/sdks toolchain work \
    && tar axvf toolchain.tar.xz -C toolchain \
    && rm toolchain.tar.xz

COPY --chown=me:me container_init_template entry /
RUN chmod +x /container_init_template /entry \
    && echo '. ~/.profile' > .bash_profile \
    && echo 'export THEOS=~/theos' >> .bash_profile \
    && echo 'export PATH="${THEOS}/bin:${THEOS}/toolchain/linux/host/bin:${PATH}"' >> .bash_profile

ENTRYPOINT [ "/entry" ]
