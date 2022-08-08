.PHONY: chain deploy upgrade test lint clean

## GLOBALS
CONTRACT=SharedWallet
NETWORK=development

## COMMANDS
chain:
	npx hardhat node --verbose

deploy: accounts
	npx oz deploy $(CONTRACT) --kind upgradeable --network $(NETWORK)

# this only works for certain changes
upgrade: 
	npx oz upgrade $(CONTRACT) --network $(NETWORK) --no-interactive

accounts:
	npx oz accounts --network $(NETWORK)

# development
test.hardhat:
	npx hardhat test

test.truffle:
	truffle test test/*

lint:
	npx prettier --write 'contracts/**/*.sol'

clean:
	-rm -r build artifacts cache .openzeppelin/dev-*


