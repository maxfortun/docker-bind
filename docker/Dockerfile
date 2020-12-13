FROM alpine:latest

RUN apk --update add bind bind-dnssec-tools

RUN rm -rf /var/cache/apk/*

EXPOSE 53/udp
EXPOSE 53/tcp

CMD ["named", "-c", "/etc/bind/named.conf", "-g", "-u", "named"]

