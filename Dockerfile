# Start writing your Dockerfile easily
FROM adoptopenjdk:8u252-b09-jdk-hotspot-bionic

ARG SERVER_JAR=minecraft_server.jar
ARG MIN_MEMORY=256M
ARG MAX_MEMORY=1G
RUN apt update && \
    apt upgrade -y

VOLUME /minecraft

EXPOSE 25565 25575

WORKDIR /minecraft

ENV UID=1000 GID=1000 \
  JVM_XX_OPTS="-XX:+UseG1GC" MEMORY=$MAX_MEMORY RCON_PORT=25575 RCON_PASSWORD=minecraft \
  LEVEL_TYPE=DEFAULT SERVER_PORT=25565 SERVER_NAME="Minecraft Server" \
  REPLACE_ENV_VARIABLES="FALSE" ENV_VARIABLE_PREFIX="CFG_" \
  ENABLE_AUTOPAUSE=false AUTOPAUSE_TIMEOUT_EST=3600 AUTOPAUSE_TIMEOUT_KN=120 AUTOPAUSE_TIMEOUT_INIT=600 AUTOPAUSE_PERIOD=10

CMD java -Xms$MIN_MEMORY -Xmx$MAX_MEMORY -jar $SERVER_JAR nogui -Dterminal.jline=false -Dterminal.ansi=true -XX:MaxPermSize=128M -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:+CMSIncrementalPacing -XX:ParallelGCThreads=7 -XX:+AggressiveOpts -XX:SurvivorRatio=2 -XX:+DisableExplicitGC -d64 
