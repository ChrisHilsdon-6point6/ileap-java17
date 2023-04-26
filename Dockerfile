### BUILD image
FROM alpine:3.17.3

# Update packages
RUN apk update && \
    apk add --upgrade apk-tools && \
    apk upgrade --available && \
    sync

ONBUILD RUN apk update && \
    apk add --upgrade apk-tools && \
    apk upgrade --available --ignore openjdk17 openjdk17-jmods openjdk17-demos openjdk17-doc java-common java-cacerts openjdk17-jre-headless openjdk17-jre openjdk17-jdk && \
    sync

# Install OpenJDK 17
RUN apk --no-cache add openjdk17 --repository=https://dl-cdn.alpinelinux.org/alpine/v3.17/community
ENV HOME /root
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

ENTRYPOINT ["/bin/ash", "-c"]

RUN mkdir -p /scripts

RUN addgroup -g 1000 -S ileap && \
    adduser -u 1000 -G ileap -h /build -s /sbin/nologin -S ileap && \
    chmod 755 /build
