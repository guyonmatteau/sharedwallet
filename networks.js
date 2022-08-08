// get required keys from .env
const dotenv = require("dotenv")
dotenv.config()
const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY;
const GOERLI_PRIVATE_KEY = process.env.GOERLI_PRIVATE_KEY;
const MNEMONIC = process.env.MNEMONIC

module.exports = {
  networks: {
    development: {
      protocol: 'http',
      host: 'localhost',
      port: 8545,
      gas: 5000000,
      gasPrice: 5e9,
      networkId: '*',
    },
    goerli: {
        url: `https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
        accounts: { mnemonic: MNEMONIC },
    }
  }
};
