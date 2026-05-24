FROM debian:trixie-slim AS base

RUN apt update
RUN apt install -y sudo git procps curl

ARG TARGETARCH
ARG CLI_VERSION
ARG CLI_URL_AMD64
ARG CLI_SHA512_AMD64
ARG CLI_URL_ARM64
ARG CLI_SHA512_ARM64

RUN if [ "$TARGETARCH" = "amd64" ]; then \
        URL=$CLI_URL_AMD64; \
        SHA512=$CLI_SHA512_AMD64; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        URL=$CLI_URL_ARM64; \
        SHA512=$CLI_SHA512_ARM64; \
    else \
        echo "Unsupported architecture: $TARGETARCH"; exit 1; \
    fi && \
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
