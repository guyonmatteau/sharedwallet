# solidtysandbox

Repo to play around with solidity on local machine instead of Remix

To do: currently the repo contains multiple frameworks: truffle, hardhat, OpenZeppelin, ganache-cli. At least choose either truffle or hardhat.

## Development

To deploy and test the contracts locally you can run your own local blockchain with Ganache (previously Ganache CLI). Install with
```
npm install -g ganache-cli
```
and in separate terminal/shell run your local blockchain
```
npx ganache-cli --deterministic
```

For development OpenZeppelin is used, which allow to upgrade existing contracts. This way we can adhere to software development best practices of starting with an MVP and iterate to improve the contract while maintaining the same contract address. Disadvantages of this approach are discussed in the essay. OpenZeppelin can be installed with
```
npm install @openzeppelin/contracts
```

Deploying Solidity contracts from the `contracts/` folder is then done by
```
npx openzeppelin deploy --kind upgradeable --network development
```
which will prompt for the contract you want to deploy.