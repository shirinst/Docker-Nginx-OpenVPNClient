############################################################
# Dockerfile для контейнера с OpenVPN-клиентом и Nginx
# Идеально подходит для локального обратного прокси. С VPN в качестве источника.
############################################################

FROM lsiobase/alpine:3.8

ARG BUILD_DATE
ARG VCS_REF

MAINTAINER shirinst
LABEL maintainer="shirinst"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-url="https://github.com/shirinst/Docker-Nginx-OpenVPNClient.git"
# "https://github.com/jacobped/Docker-Nginx-OpenVPNClient"
LABEL org.label-schema.vcs-ref=$VCS_REF

# установить пакеты
RUN apk add --no-cache \
			nginx \
			openvpn

# Будет отключено при ошибках на этапе 2.
ENV S6_BEHAVIOUR_IF_STAGE2_FAILS=2

# map logs
# VOLUME /log
COPY root/ /

VOLUME /config
EXPOSE 80
