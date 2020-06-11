FROM ubuntu:20.04

ENV CC="/usr/bin/clang"
ENV CXX="/usr/bin/clang++"
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    openssl \
    build-essential \
    git \
    python python3-pip \
    curl \ 
    gnupg2 \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \ 
    && curl https://packages.microsoft.com/config/ubuntu/19.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    # use 19.04 because 20.04 not release yet
    && apt-get update \
    && ACCEPT_EULA=Y apt-get -y --no-install-recommends install clang libc++-dev libc++abi1 cmake ninja-build msodbcsql17 unixodbc-dev \
    && pip3 install conan meson \
    # Clean up 
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]
