#!/bin/bash

# Firebase deployment script
# Usage: ./deploy-firebase.sh [token|adc]

set -e

DEPLOY_METHOD=${1:-"token"}
FIREBASE_PROJECT="workshop2-7a373"

echo "Starting Firebase deployment using ${DEPLOY_METHOD}..."

# Install Firebase CLI if not present
if ! command -v firebase &> /dev/null; then
    echo "Installing Firebase CLI..."
    npm install -g firebase-tools
fi

# Login to Firebase (for ADC method)
if [ "$DEPLOY_METHOD" = "adc" ]; then
    echo "Using Application Default Credentials..."
    if [ -n "$GOOGLE_APPLICATION_CREDENTIALS" ]; then
        export GOOGLE_APPLICATION_CREDENTIALS
        firebase deploy --only hosting --project="$FIREBASE_PROJECT"
    else
        echo "Error: GOOGLE_APPLICATION_CREDENTIALS not set for ADC method"
        exit 1
    fi
else
    echo "Using Firebase token..."
    if [ -n "$FIREBASE_TOKEN" ]; then
        firebase deploy --token "$FIREBASE_TOKEN" --only hosting --project="$FIREBASE_PROJECT"
    else
        echo "Error: FIREBASE_TOKEN not set for token method"
        exit 1
    fi
fi

echo "Firebase deployment completed successfully!"
