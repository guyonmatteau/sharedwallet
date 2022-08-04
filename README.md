# solidtysandbox

Prework for Artemis, where the goal is to develop a SharedWallet (i.e. multi-sig wallet) and deploy that to the Goerli testnet. 

## Development

Multiple commands used below are added as target to the Makefile for convenience. Run e.g. `make chain` to run your local blockchain.

### Setup

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

### Unit testing

Run JavaScript unit tests with Truffle:
```
truffle test test/js/*
```

### Essay

Todo:
- currently the repo contains multiple frameworks: truffle, hardhat, OpenZeppelin, ganache-cli. At least choose either truffle or hardhat.

Findings / challenges along the way.
- mapping does not work for maintaining transactions, unless you use the tx key (t.b.d.)
