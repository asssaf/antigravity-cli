FROM debian:trixie-slim AS base

RUN apt update
RUN apt install -y sudo git procps curl dbus gnome-keyring libsecret-1-0 xdg-utils

#ARG URL="https://antigravity.google/cli/install.sh"
#RUN curl -fsSL "$URL" | bash -s -- -d /usr/local/bin

ARG CLI_URL="https://storage.googleapis.com/antigravity-public/antigravity-cli/1.0.0-5288553236791296/linux-x64/cli_linux_x64.tar.gz"
RUN curl -fsSLo - "$CLI_URL" | tar xzv

ARG GUEST_USER=user
RUN echo "$GUEST_USER ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/user

RUN useradd -m -u 1000 $GUEST_USER
USER $GUEST_USER
WORKDIR /home/$GUEST_USER/work

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
