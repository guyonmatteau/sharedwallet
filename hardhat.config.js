/** @type import('hardhat/config').HardhatUserConfig */
require('@nomiclabs/hardhat-truffle5');
require('@nomiclabs/hardhat-ethers');

// get required keys from .env
const dotenv = require("dotenv");
dotenv.config();
const ALCHEMY_API_KEY = process.env.ALCHEMY_API_KEY;
const GOERLI_PRIVATE_KEY = process.env.GOERLI_PRIVATE_KEY;

module.exports = {
  solidity: "0.6.3",
  networks: {
    goerli: {
        url: `https://eth-goerli.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
        accounts: [GOERLI_PRIVATE_KEY],
    }
  }
};