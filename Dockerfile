FROM alpine:3.9.2
MAINTAINER kellyc@stratisiot.com

ENV JDK_NAME=zulu11.29.11-ca-jdk11.0.2-linux_musl_x64
ENV JAVA_HOME=/usr/lib/jvm/default-jvm

# Still install jdk8 to get all the libs and such it depends on
RUN apk upgrade --update-cache; \
    apk add openjdk8-jre; \
    apk add nss; \
    apk add --no-cache --update bash ca-certificates su-exec util-linux curl; \
    rm -rf /tmp/* /var/cache/apk/*

RUN cd /tmp \
    && echo "===> Install OpenJDK11 from Azul..." \
    && curl -o openjdk11.tar.gz -Lskj https://cdn.azul.com/zulu/bin/$JDK_NAME.tar.gz \
    && cd /usr/lib/jvm \
    && tar -xzf /tmp/openjdk11.tar.gz \
    && rm -f default-jvm \
    && ln -s $JDK_NAME default-jvm \
    && rm /usr/bin/java /usr/bin/appletviewer /usr/bin/keytool /usr/bin/rmiregistry \
    && ln -s /usr/lib/jvm/default-jvm/bin/java /usr/bin/java \
    && ln -s /usr/lib/jvm/default-jvm/bin/keytool /usr/bin/keytool \
    && ln -s /usr/lib/jvm/default-jvm/bin/rmiregistry /usr/bin/rmiregistry \
    && rm -rf java-1.8-openjdk /tmp/openjdk11.tar.gz

CMD ["java", "-version"]
