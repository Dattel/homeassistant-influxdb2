ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base/amd64:7.8.3
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64

RUN \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        nginx=1.22.1-9* \
        procps=2:4.0.2-3 \
    \
    && ARCH="${BUILD_ARCH}" \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    && if [ "${BUILD_ARCH}" = "armhf" ]; then ARCH="arm64"; fi \
    \
    && INFLUXDB="2.7.12" \
    && INFLUXCLI="2.7.5" \
    && curl -J -L -o /tmp/influxdb2.deb \
    "https://dl.influxdata.com/influxdb/releases/v${INFLUXDB}/influxdb2_${INFLUXDB}-1_${ARCH}.deb" \
    \
    && curl -J -L -o /tmp/influxdb-cli.deb \
    "https://dl.influxdata.com/influxdb/releases/influxdb2-client-${INFLUXCLI}-${ARCH}.deb" \
    && dpkg --install /tmp/influxdb2.deb \
    && dpkg --install /tmp/influxdb-cli.deb \
    \
    && rm -fr \
    /tmp/* \
    /etc/nginx \
    /var/{cache,log}/* \
    /var/lib/apt/lists/* \
    \
    && mkdir -p /data/influxdb2/engine \
    && mkdir -p /var/log/nginx

# Copy root filesystem
COPY rootfs /

# Fix perms -> not necessary due too appamor.txt
RUN chmod 755 /etc/s6-overlay/s6-rc.d/init-influxdb2/run
RUN chmod 755 /etc/s6-overlay/s6-rc.d/influxdb2-server/run
RUN chmod 755 /etc/s6-overlay/s6-rc.d/influxdb2-server/finish
RUN chmod 755 /etc/cont-init.d/nginx.sh
RUN chmod 755 /etc/s6-overlay/s6-rc.d/nginx/run
RUN chmod 755 /etc/s6-overlay/s6-rc.d/nginx/finish

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION
