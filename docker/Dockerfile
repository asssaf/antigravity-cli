FROM debian:trixie-slim AS base

RUN apt update
RUN apt install -y sudo git procps curl

RUN DOWNLOAD_BASE_URL=$(curl -fsSL "https://antigravity.google/cli/install.sh" | grep 'DOWNLOAD_BASE_URL=' | cut -d'"' -f2) && \
    ARCH=$(dpkg --print-architecture) && \
    MANIFEST=$(curl -fsSL "${DOWNLOAD_BASE_URL}/manifests/linux_${ARCH}.json") && \
    URL=$(echo "$MANIFEST" | sed -n 's/.*"url"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p') && \
    SHA512=$(echo "$MANIFEST" | sed -n 's/.*"sha512"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p') && \
    curl -fsSL "$URL" -o antigravity.tar.gz && \
    echo "$SHA512  antigravity.tar.gz" | sha512sum -c - && \
    tar -xzvf antigravity.tar.gz antigravity && \
    rm antigravity.tar.gz

ARG GUEST_USER=user
RUN echo "$GUEST_USER ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

RUN useradd -m -u 1000 $GUEST_USER
USER $GUEST_USER
WORKDIR /home/$GUEST_USER/work

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
