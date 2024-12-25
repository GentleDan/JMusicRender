FROM openjdk:17-jdk-slim

RUN apt-get update && apt-get install -y \
    curl jq && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y docker.io

RUN mkdir /app
WORKDIR /app

COPY config.txt /app/config.txt
COPY JMusicBot-0.4.3.2.jar /app/JMusicBot-0.4.3.2.jar
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
