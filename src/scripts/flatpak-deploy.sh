#!/bin/bash
set -e

ARCH="${PARAM_ARCH:-amd64}"
SUITE="${PARAM_SUITE:-forky}"
APP_ID="${PARAM_APP_ID}"

docker run --rm \
    -e FLATPAK_APP_ID="${APP_ID}" \
    -e ARCH="${ARCH}" \
    -e FLATPAK_SUITE="${SUITE}" \
    -e FLATPAK_REPO_DIR="/tmp/flatpak-results/repo" \
    -e FLATPAK_GPG_KEY_ID="${GPG_STAGINGPRODUCTION_SIGNING_KEYID:-}" \
    -e FLATPAK_REMOTE_TARGET="flatpak.furilabs.io:/repo/${SUITE}" \
    -e CIRCLE_PROJECT_USERNAME \
    -e CIRCLE_PROJECT_REPONAME \
    -v /tmp/flatpak-results:/tmp/flatpak-results \
    quay.io/furilabs/flatpak-builder:"${SUITE}" \
    /bin/sh -c "releng-deploy-flatpak"
