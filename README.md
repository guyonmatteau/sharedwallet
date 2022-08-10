# Artemis Prework

Artemis prework assignment 1, where the goal is to develop a SharedWallet (i.e. multi-sig wallet) and deploy that to the Goerli testnet. Address of contract:


| Network | Address | Version |
|---|---|---|
| Goerli | [0x2c603db27E6BCfb652c8301f957640AE27c22c5E](https://goerli.etherscan.io/address/0x2c603db27E6BCfb652c8301f957640AE27c22c5E) | First |
| Goerli | [0x934c31492AEDd0d74B22344617DA607b8e66Fcf2](https://goerli.etherscan.io/address/0x934c31492AEDd0d74B22344617DA607b8e66Fcf2) | Final submit |


## Development

Multiple commands used below are added as target to the Makefile for convenience. Run e.g. `make chain` to run your local node.

### Setup

To deploy and test the contracts locally you can run your own local blockchain with Hardhat. Install required packages with npm or yarn
```
yarn install
```
in separate terminal/shell run your local blockchain
```
npx hardhat node --verbose
```

### Run unit tests
```
npx hardhat test
```

### Deploy to local node

Deploying Solidity contracts from the `contracts/` folder to the node that runs locally
```
npx hardhat run --network localhost scripts/deploy.js
```
### Deploy to Goerli testnet
To deploy to the Goerli testnet, create a `.env` file in the root and add the required keys as environment variables:
- `ALCHEMY_API_KEY` containig the API key of your Alchemy account;
- `GOERLI_PRIVATE_KEY` containing the private key of the wallet you want to deploy to Goerli from.
Next, to deploy run
```
npx hardhat run --network goerli scripts/deploy.js
```

### Deploy with Docker

Running your local node or deployment from within a docker container has not been fully implemented yet.