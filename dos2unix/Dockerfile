FROM debian:stable-slim

ENV DEBIAN_FRONTEND noninteractive
ENV RUNLEVEL 1

RUN apt-get update && apt-get install -y dos2unix

ENTRYPOINT ["dos2unix"]

FROM debian:stable-slim # Указывает, что базовым образом для сборки будет образ Debian в версии stable-slim.

ENV DEBIAN_FRONTEND noninteractive # Указывает, что при установке пакетов не будет отображаться интерфейс установки.

ENV RUNLEVEL 1 # Указывает уровень запуска системы.

RUN apt-get update && apt-get install -y dos2unix # Указывает, что будет производиться установка пакета dos2unix.

ENTRYPOINT ["dos2unix"] # Указывает, что при запуске контейнера будет запускаться команда dos2unix.
