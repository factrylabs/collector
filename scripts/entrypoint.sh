#!/bin/sh
set -e

if [ -z "$API_TOKEN" ]; then
    echo "API_TOKEN is not set"
    exit 1
fi

# If the /opt/factry/collector binary is not present, download it
if [ ! -f /opt/factry/collector ]; then
    echo "No collector binary found, downloading"

    if [ -z "$PRODUCT" ]; then
        echo "PRODUCT is not set"
        exit 1
    fi

    OS=linux
    ARCH=${ARCH:-amd64}
    VERSION=${VERSION:-latest}
    PORTAL_URL=${PORTAL_URL:-https://portal.factry.cloud}
    RELEASE_CHANNEL=${RELEASE_CHANNEL:-stable}

    # Download
    echo "Downloading $PRODUCT $VERSION for $OS/$ARCH"

    if [ "$VERSION" = "latest" ]; then
        JQ_SELECTOR=". [] | select( .Arch ==\"${ARCH}\" ) | select( .OS == \"${OS}\" ) | .DownloadURL"
        DOWNLOAD_URL=$(curl "${PORTAL_URL}/api/product-updates?Products\[0\]=${PRODUCT}&ReleaseChannel=${RELEASE_CHANNEL}&LatestVersions=true" | jq -r "${JQ_SELECTOR}")

    else
        JQ_SELECTOR=". [] | select( .Arch ==\"${ARCH}\" ) | select( .OS == \"${OS}\" ) |  select( .Version==\"${VERSION}\" ) | .DownloadURL"
        DOWNLOAD_URL=$(curl "${PORTAL_URL}/api/product-updates?Products\[0\]=${PRODUCT}&ReleaseChannel=${RELEASE_CHANNEL}" | jq -r "${JQ_SELECTOR}")
    fi

    if [ -z "$DOWNLOAD_URL" ]; then
        echo "No download URL found for $PRODUCT $VERSION for $OS/$ARCH"
        exit 1
    fi

    echo "Downloading $DOWNLOAD_URL"
    curl -L -o /opt/factry/collector $DOWNLOAD_URL
    chmod +x /opt/factry/collector
fi

# Run
echo "Running collector"

exec /opt/factry/collector
