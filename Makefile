.PHONY: chain deploy test lint clean
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

deploy: accounts
	npx hardhat run --network localhost scripts/deploy.js

accounts: 
	npx hardhat run --network localhost scripts/accounts.js

test:
	npx hardhat test

console:
	npx hardhat console --network localhost

# Development
lint:
	npx prettier --write contracts/**/*.sol test/** scripts/**

clean:
	-rm -r build artifacts cache .openzeppelin/dev-*

### DEPLOYMENT - not implemented yet
# build:
# 	docker build -t $(DOCKER_IMAGE):$(DOCKER_TAG) .

# run: build 
# 	@docker run -it --rm $(DOCKER_ENV) $(DOCKER_PORTS) $(DOCKER_IMAGE):$(DOCKER_TAG)
 
