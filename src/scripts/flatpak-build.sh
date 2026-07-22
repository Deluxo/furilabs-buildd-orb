#!/bin/bash
set -e

MANIFEST="${PARAM_MANIFEST}"
ARCH="${PARAM_ARCH:-amd64}"
SUITE="${PARAM_SUITE:-forky}"

mkdir -p /tmp/flatpak-results

docker run --rm \
    -e FLATPAK_MANIFEST="${MANIFEST}" \
    -e ARCH="${ARCH}" \
    -e FLATPAK_SUITE="${SUITE}" \
    -e CI \
    -e CIRCLECI \
    -e CIRCLE_BRANCH \
    -e CIRCLE_SHA1 \
    -e CIRCLE_TAG \
    -e CIRCLE_PROJECT_USERNAME \
    -e CIRCLE_PROJECT_REPONAME \
    -v /tmp/flatpak-results:/tmp/flatpak-results \
    -v "${PWD}":/buildd/sources \
    -w /buildd/sources \
    quay.io/furilabs/flatpak-builder:"${SUITE}" \
    /bin/sh -c "releng-build-flatpak"
