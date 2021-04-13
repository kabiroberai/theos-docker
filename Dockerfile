FROM ubuntu:20.04

RUN useradd -ms /bin/bash me
WORKDIR /home/me

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
    && rm -rf /var/lib/apt/lists/*

ADD --chown=me:me \
    https://swift.org/builds/swift-5.3.3-release/ubuntu2004/swift-5.3.3-RELEASE/swift-5.3.3-RELEASE-ubuntu20.04.tar.gz \
    swift.tar.zst

ADD --chown=me:me \
    https://github.com/CRKatri/llvm-project/releases/download/swift-5.3.2-RELEASE/swift-5.3.2-RELEASE-ubuntu20.04.tar.zst \
    toolchain.tar.zst

USER me

RUN mkdir -p theos/sdks toolchain/linux/iphone work host-swift \
    && tar axvf toolchain.tar.zst -C toolchain/linux/iphone --strip-components 1 \
    && tar axvf swift.tar.zst -C host-swift --strip-components 1 \
    && rm toolchain.tar.zst swift.tar.zst

USER root

COPY entry.sh /entry
RUN chmod +x /entry

ENTRYPOINT [ "/entry" ]
