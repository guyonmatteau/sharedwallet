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

# Install dependencies
RUN mkdir -p /opt
WORKDIR /opt
COPY package.json .
COPY yarn.lock .

# Workaround for an issue with yarn and git
RUN git config --global url."https://github.com/".insteadOf ssh://git@github.com/ && \
    git config --global url."https://".insteadOf git://
RUN yarn install --non-interactive --frozen-lockfile

# COPY files required for deployment
COPY hardhat.config.js .
COPY contracts contracts
COPY scripts scripts

