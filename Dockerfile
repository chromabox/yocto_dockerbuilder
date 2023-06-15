FROM ubuntu:20.04

# get package
RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    chrpath \
    curl \
    cpio \
    debianutils \
    diffstat \
    gawk \
    gcc \
    gcc-multilib \
    git \
    iputils-ping \
    libegl1-mesa \
    libsdl1.2-dev \
    mesa-common-dev \
    pylint3 \
    python \
    python3 \
    python3-git \
    python3-jinja2 \
    python3-pexpect \
    python3-pip \
    python3-subunit \
    socat \
    texinfo \
    unzip \
    wget \
    xterm \
    xz-utils \
    gosu \
    language-pack-en \
    sudo \
    tmux \
    lz4 \ 
    zstd \ 
    bsdmainutils \
    libgmp-dev \
    libmpc-dev \
    libssl-dev \   
    gdisk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# get repo-tool from google
RUN \
  curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo \ 
  && chmod 755 /usr/local/bin/repo

# update locale (Yocto requirements)
RUN \
  update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# add local user (user name buildman)
RUN \
  useradd -ms /bin/bash buildman && \
  echo "buildman ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# local user git setting (Yocto requirements)
USER buildman
RUN \
  git config --global user.email "buildman@localhost" && \
  git config --global user.name "buildman"

# set env
USER root
WORKDIR /home/buildman

CMD ["/bin/bash"]

ENV \
  LANG=en_US.UTF-8 \
  LC_ALL=en_US.UTF-8 \
  LANGUAGE=en_US.UTF-8

