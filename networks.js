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
        accounts: `${GOERLI_PRIVATE_KEY}`
    }
  }
};
