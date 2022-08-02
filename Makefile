.PHONY: chain deploy

# targets
chain:
	npx ganache-cli --deterministic

deploy:
	npx openzeppelin deploy --kind upgradeable --network development