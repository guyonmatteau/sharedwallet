.PHONY: chain deploy test


chain:
	npx ganache-cli --deterministic

deploy:
	npx openzeppelin deploy --kind upgradeable --network development

# development
test:
	truffle test test/js/*

lint:
	npx prettier --write 'contracts/**/*.sol'

clean:
	rm -r build artifacts cache

