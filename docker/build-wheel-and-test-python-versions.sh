#!/usr/bin/env bash
#

if [ ! -d .git ]; then
  echo "This script must be run from the root of the aiko_services Git repository."
  exit 1
fi

GIT_DESCRIBE="$(git describe --tags --always)"
function test_sdk_python_version {
  set -ex

  PYTHON_VERSION="$1"
  IMAGE_NAME_TAG="aiko-services-$PYTHON_VERSION:$GIT_DESCRIBE"
  docker build --build-arg="PYTHON_VERSION=$PYTHON_VERSION" \
               -t "$IMAGE_NAME_TAG" \
               -f docker/Dockerfile \
               .
  docker run --rm \
      -e AIKO_MQTT_HOST=localhost \
      "$IMAGE_NAME_TAG" \
      python -c "import akio_services"   # ToDo: Run actual unit tests

  docker rmi "$IMAGE_NAME_TAG"
}

hatch build
test_sdk_python_version 3.9
test_sdk_python_version 3.10
test_sdk_python_version 3.11
test_sdk_python_version 3.12
