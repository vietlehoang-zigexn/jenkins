#!/bin/bash

# Deploy script for remote server
# Usage: ./deploy-remote.sh

set -e

BUILD_DATE=$(date +%Y%m%d)
REMOTE_HOST="10.1.1.195"
REMOTE_USER="newbie"
REMOTE_PORT="3334"
SSH_KEY="~/.ssh/newbie_id_rsa"
REMOTE_BASE="/usr/share/nginx/html/jenkins/yourname2"
PROJECT_DIR="workshop2"

echo "Starting remote deployment..."

# Create remote directory structure
echo "Creating remote directories..."
ssh -i "${SSH_KEY}" -o StrictHostKeyChecking=no -p "${REMOTE_PORT}" "${REMOTE_USER}@${REMOTE_HOST}" "
    mkdir -p ${REMOTE_BASE}/${PROJECT_DIR}
    mkdir -p ${REMOTE_BASE}/deploy/${BUILD_DATE}
    mkdir -p ${REMOTE_BASE}/deploy/current
"

# Copy files to remote
echo "Copying files to remote server..."
scp -i "${SSH_KEY}" -o StrictHostKeyChecking=no -P "${REMOTE_PORT}" index.html "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_BASE}/${PROJECT_DIR}/"
scp -i "${SSH_KEY}" -o StrictHostKeyChecking=no -P "${REMOTE_PORT}" 404.html "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_BASE}/${PROJECT_DIR}/"
scp -i "${SSH_KEY}" -o StrictHostKeyChecking=no -P "${REMOTE_PORT}" -r css "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_BASE}/${PROJECT_DIR}/"
scp -i "${SSH_KEY}" -o StrictHostKeyChecking=no -P "${REMOTE_PORT}" -r js "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_BASE}/${PROJECT_DIR}/"
scp -i "${SSH_KEY}" -o StrictHostKeyChecking=no -P "${REMOTE_PORT}" -r images "${REMOTE_USER}@${REMOTE_HOST}:${REMOTE_BASE}/${PROJECT_DIR}/"

# Copy to deploy folder and create symlink
echo "Setting up deployment structure..."
ssh -i "${SSH_KEY}" -o StrictHostKeyChecking=no -p "${REMOTE_PORT}" "${REMOTE_USER}@${REMOTE_HOST}" "
    cp -r ${REMOTE_BASE}/${PROJECT_DIR}/* ${REMOTE_BASE}/deploy/${BUILD_DATE}/
    
    # Create symlink
    rm -f ${REMOTE_BASE}/deploy/current
    ln -s ${REMOTE_BASE}/deploy/${BUILD_DATE} ${REMOTE_BASE}/deploy/current
    
    # Keep only 5 recent deployments
    cd ${REMOTE_BASE}/deploy
    ls -t | tail -n +6 | xargs -r rm -rf
"

echo "Remote deployment completed successfully!"
echo "Remote deployment location: ${REMOTE_BASE}/deploy/current"
