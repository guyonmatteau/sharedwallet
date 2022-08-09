.PHONY: chain deploy upgrade test lint clean
include .env
export 

### GLOBALS
CONTRACT=SharedWallet
NETWORK=localhost
DOCKER_IMAGE=sharedwallet
DOCKER_TAG=$(shell git branch --show-current)
DOCKER_ENV=-e ALCHEMY_API_KEY=$(ALCHEMY_API_KEY) -e PRIVATE_KEY=$(PRIVATE_KEY)
DOCKER_PORTS=-p 8545:8545

### DEVELOPMENT

# Starting local node
chain:
	npx hardhat node --verbose

# Openzeppelin
oz.deploy: oz.accounts
	npx oz deploy $(CONTRACT) --kind upgradeable --network $(NETWORK)

oz.upgrade: # this only works for certain changes
	npx oz upgrade $(CONTRACT) --network $(NETWORK) --no-interactive

oz.accounts:
	npx oz accounts --network $(NETWORK)

# Hardhat
hh.deploy: hh.accounts
	npx hardhat run --network localhost scripts/deploy.js

hh.accounts: 
	npx hardhat run --network localhost scripts/accounts.js

hh.test:
	npx hardhat test

# Truffle
truffle.test:
	truffle test test/*

# Development
lint:
	npx prettier --write contracts/**/*.sol test/**

clean:
	-rm -r build artifacts cache .openzeppelin/dev-*


### DEPLOYMENT
build:
	docker build -t $(DOCKER_IMAGE):$(DOCKER_TAG) .

run: build 
	@docker run -it --rm $(DOCKER_ENV) $(DOCKER_PORTS) $(DOCKER_IMAGE):$(DOCKER_TAG)
 