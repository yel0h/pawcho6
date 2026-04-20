# STAGE 1: pobranie repo przez SSH
FROM alpine AS source

RUN apk add --no-cache git openssh

RUN mkdir -p -m 0700 /root/.ssh && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN --mount=type=ssh \
    git clone git@github.com:yel0h/pawcho6.git /repo

# STAGE 1: budowanie aplikacji
FROM scratch AS builder

ADD alpine-minirootfs-3.23.3-x86_64.tar /

ARG VERSION=1.0

COPY --from=source /repo /app

RUN IP=$(hostname -i) && \
    HOST=$(hostname) && \
    echo "<!DOCTYPE html>" > /index.html && \
    echo "<html><head><title>Info</title></head><body>" >> /index.html && \
    echo "<h1>Informacje o serwerze</h1>" >> /index.html && \
    echo "<p><b>Adres IP:</b> ${IP}</p>" >> /index.html && \
    echo "<p><b>Hostname:</b> ${HOST}</p>" >> /index.html && \
    echo "<p><b>Wersja aplikacji:</b> ${VERSION}</p>" >> /index.html && \
    echo "</body></html>" >> /index.html


# STAGE 2: serwer Nginx
FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY --from=builder /index.html /usr/share/nginx/html/index.html

HEALTHCHECK --timeout=5s --start-period=5s \
    CMD wget -q -O /dev/null http://localhost || exit 1

EXPOSE 80