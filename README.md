# Factry Historian Collector for Docker

This repository contains the Dockerfile and scripts to build a Docker image for a Factry Historian Collector. The Factry Historian Collector is a data collection agent that can be used to collect data from various sources and store it in a Factry Historian. This image can be used to run the Factry Historian Collector in a Docker container.

## Requirements

- Docker
- API token for the Collector
- A working internet connection or a local binary of the Collector

## Usage

If you have a working internet connection, you can run the Factry Historian Collector in a Docker container using the following command:

```bash
docker run -d --name factry-collector -e API_TOKEN=<API_TOKEN> -e PRODUCT=<PRODUCT_NAME>ghcr.io/factrylabs/collector:latest
```

Replace `<API_TOKEN>` with your API token for the Collector. You can generate your API token in the Factry Historian web interface.
Replace `<PRODUCT_NAME>` with the name of the product you want to collect data for.

The product names available are:

- `opc-ua` for OPC UA data sources
- `modbus` for Modbus TCP data sources
- `mqtt-sparkplugb` for MQTT Sparkplug B data sources
- `mqtt-generic` for generic MQTT data sources
- `sql` for SQL data sources

If you do not have a working internet connection, you can download the binary of the Factry Historian Collector from the Factry Portal and copy it to your local machine.  You can that run the Factry Historian Collector in a Docker container using the following command:

```bash
docker run -v <PATH_TO_BINARY>:/opt/factry/collector -d --name factry-collector -e API_TOKEN=<API_TOKEN>  ghcr.io/factrylabs/collector:latest
```

Replace `<PATH_TO_BINARY>` with the path to the binary of the Factry Historian Collector on your local machine. If you wish to make use of the auto-update feature, you must make sure that permissions are set correctly on the binary for the user running the Docker container.

## Additional Configuration via Environment Variables

The Factry Historian Collector can be configured using environment variables. The following environment variables are available:

- `API_TOKEN`: The API token for the Collector (required)
- `PRODUCT`: The name of the collector product (required if the binary is not available)
- `ARCH`: The architecture of the collector binary that needs to be downloaded (default: `amd64`). Available options are `amd64`, `armv7`, `armv6` and `arm64`.
- `VERSION`: The version of the collector binary that needs to be downloaded (default: `latest`). Example: `v1.0.0`.
- `RELEASE_CHANNEL`: The release channel of the collector binary that needs to be downloaded (default: `stable`). Available options are `stable` and `preview`.
