.PHONY: chain deploy upgrade test lint clean

# blockchain
chain:
	npx ganache-cli --deterministic --verbose

deploy:
	npx openzeppelin deploy --kind upgradeable --network development

# this only works for certain incremental changes
upgrade: 
	npx oz upgrade SharedWallet --network development --no-interactive

# development
test:
	truffle test test/js/*

lint:
	npx prettier --write 'contracts/**/*.sol'

clean:
	rm -r build artifacts cache


