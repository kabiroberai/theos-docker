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
    zip \
    rsync \
    && rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos '' me \
    && usermod -aG sudo me \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR /home/me
USER me

RUN mkdir -p theos/sdks toolchain work \
    && curl -#L https://github.com/kabiroberai/swift-toolchain-linux/releases/download/v2.2.1/swift-5.7-ubuntu20.04$([ "$(uname -m)" = aarch64 ] && echo -aarch64).tar.xz \
    | tar xvJ -C toolchain

COPY --chown=me:me container_init_template entry /
RUN chmod +x /container_init_template /entry \
    && echo '. ~/.profile' > .bash_profile \
    && echo 'export THEOS=~/theos' >> .bash_profile \
    && echo 'export PATH="${THEOS}/bin:${THEOS}/toolchain/linux/host/bin:${PATH}"' >> .bash_profile \
    && echo 'export LC_ALL=C' >> .bash_profile

ENTRYPOINT [ "/entry" ]
