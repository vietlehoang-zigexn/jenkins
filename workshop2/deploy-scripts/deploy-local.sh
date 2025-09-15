#!/bin/bash

# Deploy script for local server
# Usage: ./deploy-local.sh

set -e

BUILD_DATE=$(date +%Y%m%d)
DEPLOY_DIR="/tmp/deploy"
PROJECT_DIR="workshop2"

echo "Starting local deployment..."

# Create deployment directory structure
mkdir -p "${DEPLOY_DIR}/${BUILD_DATE}"
mkdir -p "${DEPLOY_DIR}/current"

# Copy necessary files only (as per requirements)
echo "Copying files..."
cp index.html "${DEPLOY_DIR}/${BUILD_DATE}/"
cp 404.html "${DEPLOY_DIR}/${BUILD_DATE}/"
cp -r css "${DEPLOY_DIR}/${BUILD_DATE}/"
cp -r js "${DEPLOY_DIR}/${BUILD_DATE}/"
cp -r images "${DEPLOY_DIR}/${BUILD_DATE}/"

# Create symlink
echo "Creating symlink..."
rm -f "${DEPLOY_DIR}/current"
ln -s "${DEPLOY_DIR}/${BUILD_DATE}" "${DEPLOY_DIR}/current"

# Keep only 5 recent deployments
echo "Cleaning up old deployments..."
cd "${DEPLOY_DIR}"
ls -t | tail -n +6 | xargs -r rm -rf

echo "Local deployment completed successfully!"
echo "Deployment location: ${DEPLOY_DIR}/current"
