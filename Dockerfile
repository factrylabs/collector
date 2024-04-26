FROM alpine:3.19

# Install curl and jq

RUN apk add --no-cache curl jq

# Copy the script into the container

COPY ./scripts/entrypoint.sh /entrypoint.sh

# Create and set the working directory

RUN mkdir -p /var/opt/factry
RUN mkdir -p /opt/factry

WORKDIR /var/opt/factry

# Set the entrypoint

ENTRYPOINT ["/entrypoint.sh"]
