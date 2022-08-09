.PHONY: chain deploy upgrade test lint clean

## GLOBALS
CONTRACT=SharedWallet
NETWORK=localhost

## Starting local node
chain:
	npx hardhat node --verbose

## Openzeppelin
oz.deploy: oz.accounts
	npx oz deploy $(CONTRACT) --kind upgradeable --network $(NETWORK)

oz.upgrade: # this only works for certain changes
	npx oz upgrade $(CONTRACT) --network $(NETWORK) --no-interactive

oz.accounts:
	npx oz accounts --network $(NETWORK)

## Hardhat
hh.deploy: hh.accounts
	hardhat run --network localhost scripts/deploy.js

hh.accounts: 
	hardhat run --network localhost scripts/accounts.js

hh.test:
	npx hardhat test

## Truffle
truffle.test:
	truffle test test/*

## Development
lint:
	npx prettier --write contracts/**/*.sol test/**

clean:
	-rm -r build artifacts cache .openzeppelin/dev-*


