# Docker-Nginx-OpenVPNClient
Контейнер с питанием от Docker для использования Nginx в сочетании с клиентом OpenVPN.

Идеально подходит для локального обратного прокси с входящими запросами, поступающими через соединение OpenVPN.

### Docker Image
[![Docker Pulls](https://img.shields.io/docker/pulls/jacobpeddk/nginx-openvpnclient.svg)](https://hub.docker.com/r/jacobpeddk/nginx-openvpnclient)
[![Docker Stars](https://img.shields.io/docker/stars/jacobpeddk/nginx-openvpnclient.svg)](https://hub.docker.com/r/jacobpeddk/nginx-openvpnclient)
[![](https://images.microbadger.com/badges/image/jacobpeddk/nginx-openvpnclient.svg)](https://microbadger.com/images/jacobpeddk/nginx-openvpnclient "Container Image size and layers")
[![](https://images.microbadger.com/badges/commit/jacobpeddk/nginx-openvpnclient.svg)](https://microbadger.com/images/jacobpeddk/nginx-openvpnclient "Current commit that the container is build from")
[![](https://images.microbadger.com/badges/version/jacobpeddk/nginx-openvpnclient.svg)](https://microbadger.com/images/jacobpeddk/nginx-openvpnclient "Container version")

### Пример сценария:
У вас есть хост-докер с контейнерами в вашей локальной сети, который вы хотели бы иметь доступ к внешнему миру, но вы не можете открыть порты брандмауэра. Или вы просто предпочитаете, чтобы внешний ip для услуг происходил где-то еще. Получите VPS и настройте его с помощью OpenVPN Host и Nginx для обратного прокси-трафика из него. Затем настройте этот контейнер с помощью пользовательской конфигурации nginx и конфигурации подключения клиента OpenVPN, которая может подключаться к OpenVPN Host.

Таким образом, вы можете настроить его таким образом, когда кто-то посещает ваши vps на данном порту, что вы пересылаете трафик от к клиенту vpn, запрос будет проксироваться через vpn-соединение с контейнером. И оттуда установленный экземпляр Nginx будет проксировать этот запрос к какому-либо другому контейнеру(ы) или службе(ы), которые вы определили.

Веб-браузер -> VPS --VPN-Tunnel-> Этот Контейнер -> Сервис

Это немного сложно, но совершенно удивитеcm, когда его запустите. Вы также можете проксировать в обратном направлении, если настроить конфигурацию Nginx нужным образом.

### Примечание
Контейнер поставляется с конфигурациями образов, которые будут добавлены в отображаемый том /config, если они еще не существуют. Просто перепишите их в соответствии с вашими потребностями.

## Использование

```
docker create \
  --name=nginxopenvpn \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 8282:80 \
  --cap-add=NET_ADMIN \
  --device=/dev/net/tun \
  jacobpeddk/nginx-openvpnclient
```

### Port mapping
Сопоставление портов является необязательным и необходимо только для тестирования конфигурации обратного прокси nginx локально.
Чтобы проверить его на месте, посетите:: `<host ip>:8282`

### PGID and PUID
Определит пользовательские и групповые средства, которые контейнер будет обрабатывать файлы и процессы, как.

PGID можно найти, выполнив:  `id -g`
PUID можно найти, выполнив:  `id -u`  

## Build & Run
Загрузите репозиторий и запустите следующую команду на хосте для создания образа.
```
docker build -t nginx-openvpnclient .
```

Чтобы проверить его:
```
docker run -it --rm --name nginxopenvpn -e PGID=<gid> -e PUID=<uid> -p 8282:80 --cap-add=NET_ADMIN --device=/dev/net/tun -v <localConfigPath>:/config nginx-openvpnclient
```
И если все настроено правильно, теперь он должен подключить траффик через прокси, соединившись с подключением vpn.

# Полезные ресурсы сайта
 * [linuxserver.io alpine базовое изображение](https://github.com/linuxserver/docker-baseimage-alpine/)
 * [S6 сервис-обработчик для контейнеров](https://github.com/just-containers/s6-overlay)
 * [Информация о программе s6-svscanctl](https://skarnet.org/software/s6/s6-svscanctl.html)


# Changelog
Важные изменения будут перечислены здесь.

Паттерн: год-месяц-дата

### 2018-08-19

Основные изменения в изображении. Сделал его гораздо более прочным и меньшим по размеру.

* Удален dos2unix - больше не будет исправлять файлы, созданные с неправильной строкой, заканчивающейся на окнах.
* Изменяет базу изображения на альпийское изображение с поддержкой s6 от linuxserver.io [linuxserver.io](https://github.com/linuxserver/docker-baseimage-alpine/)
* Изменил все, чтобы использовать обработчик обслуживания [s6 service handler](https://github.com/just-containers/s6-overlay). 
* log dir теперь является частью config dir.
* Общий размер изображения уменьшился с 70MB до 9MB.
