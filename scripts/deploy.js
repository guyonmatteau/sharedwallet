

async function main () {
  // We get the contract to deploy
  const SharedWallet = await ethers.getContractFactory('SharedWallet');
  console.log('Deploying SharedWallet...');
  const sharedwallet = await SharedWallet.deploy();
  await sharedwallet.deployed();
  console.log('SharedWallet deployed to:', sharedwallet.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
