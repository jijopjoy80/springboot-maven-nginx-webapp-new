FROM debian:stable-slim

# Set working directory
WORKDIR /app

# Add a shell script as entrypoint
COPY entrypoint.sh .

# Make it executable
RUN chmod +x entrypoint.sh

# Set entrypoint
ENTRYPOINT ["./entrypoint.sh"]

