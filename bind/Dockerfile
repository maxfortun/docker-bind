ARG REPO
ARG NAME
ARG VERSION
ARG LAST_LAYER

FROM $REPO/sshd:latest

COPY fs /

RUN /tmp/configure_bind.sh || exit $?

EXPOSE 53/udp
EXPOSE 53/tcp

