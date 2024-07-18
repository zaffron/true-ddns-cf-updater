# Use an official lightweight image as the base
FROM alpine:latest

# Install necessary packages
RUN apk add --no-cache curl jq

# Set the working directory
WORKDIR /app

# Copy the script into the container
COPY script.sh .

# Make the script executable
RUN chmod +x script.sh

# Set default environment variables
ENV URL="http://192.168.1.1/cgi-bin/json/diagnoseStatus.json"
ENV CF_ZONE_ID=""
ENV CF_DNS_RECORD_ID=""
ENV CF_AUTH_EMAIL=""
ENV CF_AUTH_TOKEN=""
ENV CF_RECORD_NAME=""
ENV CF_TTL=3600

# Add a crontab file
COPY crontab /etc/crontabs/root

# Run the script every day
ENTRYPOINT ["/bin/sh", "-c", "/app/script.sh && crond -f"]
