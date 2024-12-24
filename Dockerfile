FROM openjdk:17-jdk-slim

WORKDIR /app

COPY JMusicBot-0.4.3.2.jar /app/JMusicBot-0.4.3.2.jar
COPY config.txt /app/config.txt

CMD ["java", "-jar", "JMusicBot-0.4.3.2.jar"]