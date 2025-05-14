# FROM debian:stable-slim

# # Set working directory
# WORKDIR /app

# # Add a shell script as entrypoint
# COPY entrypoint.sh .

# # Make it executable
# RUN chmod +x entrypoint.sh

# # Set entrypoint
# ENTRYPOINT ["./entrypoint.sh"]
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    unzip \
    wget \
    curl

# Install AWS CLI
RUN pip3 install awscli

# Download and install the Amazon CloudWatch Logs Agent
RUN wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
RUN dpkg -i -E ./amazon-cloudwatch-agent.deb
RUN mkdir -p /opt/aws/amazon-cloudwatch-agent/etc
COPY ./env-config.json /opt/aws/amazon-cloudwatch-agent/etc/env-config.json
# Create CloudWatch Logs configuration file
COPY ./amazon-cloudwatch-agent.json /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json

# Copy your application code
COPY . /my_app

# Create log directory and set permissions
RUN mkdir -p /var/log && \
    touch /var/log/your_app.log && \
    chmod 666 /var/log/your_app.log

# Ensure the CloudWatch agent directory has the right permissions
RUN chown -R root:root /opt/aws/amazon-cloudwatch-agent

CMD tail -f /dev/null
# Set the entrypoint to start CloudWatch Agent and your application
ENTRYPOINT ["/bin/bash", "-c", "/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent -config file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json & python3 /my_app/app.py"]

