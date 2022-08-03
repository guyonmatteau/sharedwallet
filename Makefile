.PHONY: chain deploy test

# targets
chain:
	npx ganache-cli --deterministic

deploy:
	npx openzeppelin deploy --kind upgradeable --network development

test:
	truffle test test/js/*