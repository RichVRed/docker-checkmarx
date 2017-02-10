# BUILD:
# docker build --force-rm --tag "rvannauker/checkmarx" --file checkmarx.dockerfile .
# RUN:
# docker run -v ${PWD}:/usr/src --net=host "rvannauker/checkmarx" Scan -CxServer {server} -ProjectName {projectName} -CxUser {username} -CxPassword {password} -Incremental -LocationType {location_type} -LocationPath {location_path} -LocationPathExclude "{exclude_paths}" -v
# PACKAGE: Checkmarx
# PACKAGE REPOSITORY: https://www.checkmarx.com/
# DESCRIPTION: A static analysis engine
FROM alpine:latest
MAINTAINER Richard Vannauker <richard.vannauker@gmail.com>
# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL     org.label-schema.schema-version="1.0" \
          org.label-schema.build-date="$BUILD_DATE" \
          org.label-schema.version="$VERSION" \
          org.label-schema.name="" \
          org.label-schema.description="" \
          org.label-schema.vendor="SEOHEAT LLC" \
          org.label-schema.url="" \
          org.label-schema.vcs-ref="$VCS_REF" \
          org.label-schema.vcs-url="" \
          org.label-schema.usage="" \
          org.label-schema.docker.cmd="" \
          org.label-schema.docker.cmd.devel="" \
          org.label-schema.docker.cmd.test="" \
          org.label-schema.docker.cmd.debug="" \
          org.label-schema.docker.cmd.help="" \
          org.label-schema.docker.params="" \
          org.label-schema.rkt.cmd="" \
          org.label-schema.rkt.cmd.devel="" \
          org.label-schema.rkt.cmd.test="" \
          org.label-schema.rkt.cmd.debug="" \
          org.label-schema.rkt.cmd.help="" \
          org.label-schema.rkt.params="" \
          com.amazonaws.ecs.task-arn="" \
          com.amazonaws.ecs.container-name="" \
          com.amazonaws.ecs.task-definition-family="" \
          com.amazonaws.ecs.task-definition-version="" \
          com.amazonaws.ecs.cluster=""

VOLUME ["/usr/src", "/usr/output"]
WORKDIR /usr/src

ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ARG CHECKMARK_CX_CLI_URL="http://download.checkmarx.com/8.2.0/Plugins/CxConsolePlugin-CLI-7.5.0.3.zip"

RUN apk add --no-cache openjdk8 && \
    ln -sf "${JAVA_HOME}/bin/"* "/usr/bin/" && \
    wget ${CHECKMARK_CX_CLI_URL} -O /tmp/cli.zip && \
    mkdir -p /opt/CxConsolePlugin && \
    unzip /tmp/cli.zip -d /tmp && \
    mv /tmp/CxConsolePlugin-7.5.0-20160719-1414/* /opt/CxConsolePlugin && \
    rm -rf /tmp/cli.zip && \
    rm -rf /tmp/CxConsolePlugin-7.5.0-20160719-1414 && \
    chmod +x /opt/CxConsolePlugin/runCxConsole.sh && \
    rm -rf /var/cache/apk/*

# Add path to Java
ENV PATH=${JAVA_HOME}/bin:$PATH

ENTRYPOINT ["/opt/CxConsolePlugin/runCxConsole.sh"]