FROM node:14-buster-slim

# Needed for npm dependencies
RUN apt-get update && \
    apt-get install -y \
    python3.7 \
    make \
    gcc \
    g++ \
    git \
    curl

# Making sure we are able to run hardhad in container, not robust but fine for now
RUN npm set strict-ssl=false  
RUN npm config set user 0
RUN npm config set unsafe-perm true

# Install dependencies
RUN mkdir -p /opt
WORKDIR /opt
COPY package.json .

# COPY files required for deployment
COPY hardhat.config.js .
COPY contracts contracts
COPY scripts scripts

CMD npx hardhat node --verbose

