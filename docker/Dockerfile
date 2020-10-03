FROM alpine:latest

RUN apk --update add bind bind-dnssec-tools

EXPOSE 53/udp
EXPOSE 53/tcp

CMD ["named", "-c", "/etc/bind/named.conf", "-g", "-u", "named"]

