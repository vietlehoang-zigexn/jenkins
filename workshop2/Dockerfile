FROM node:20-alpine

# Install system dependencies
RUN apk add --no-cache \
    openssh-client \
    curl \
    bash \
    git

# Install Firebase CLI globally
RUN npm install -g firebase-tools

# Set working directory
WORKDIR /workspace

# Copy package files first for better caching
COPY package*.json ./

# Install project dependencies
RUN npm install

# Copy the rest of the project
COPY . .

# Set proper permissions
RUN chown -R node:node /workspace
USER node

# Default command
CMD ["node", "--version"]
