FROM openjdk:17-jdk-slim

RUN apt-get update && apt-get install -y \
    curl jq && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /app
WORKDIR /app

RUN echo "#!/bin/bash\n\noutput=$(docker run --rm quay.io/invidious/youtube-trusted-session-generator)\n\nvisitor_data=$(echo \"$output\" | grep -oP 'visitor_data: \K.*')\npo_token=$(echo \"$output\" | grep -oP 'po_token: \K.*')\n\nif [ -z \"$visitor_data\" ] || [ -z \"$po_token\" ]; then\n  echo \"Error: Failed to extract required values\"\n  exit 1\nfi\n\necho \"VISITOR_DATA=$visitor_data\" > .env\necho \"PO_TOKEN=$po_token\" >> .env" > fetch_tokens.sh && \
    chmod +x fetch_tokens.sh && \
    ./fetch_tokens.sh

COPY config.txt /app/config.txt
COPY JMusicBot-0.4.3.2.jar /app/JMusicBot-0.4.3.2.jar

ENV VISITOR_DATA $(grep VISITOR_DATA .env | cut -d'=' -f2)
ENV PO_TOKEN $(grep PO_TOKEN .env | cut -d'=' -f2)

CMD ["java", "-Dnogui=true", "-jar", "JMusicBot-0.4.3.2.jar"]
