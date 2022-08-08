const { assert } = require("chai");

const SharedWallet = artifacts.require("SharedWallet");

contract("SharedWallet", (accounts) => {
  let deployer = accounts[0];
  let owner = accounts[1];


//   it("should not accept the zero address as owner", async function () {

//     const walletInstance = await SharedWallet.deployed();

//     const value = await walletInstance.initialize(address(0));

//     assert.equal(2, 2, "Values don't match");
//   });

  it("should set the owners properly", async function() {

    
    const walletInstance = await SharedWallet.deployed().initialize([deployer], 1);

    owners = await walletInstance.getOwners();

    assert.equal(owners, [owner]);


  })
      

  // contract should not be able to be initialized more than once
  it("should not be able to be initialized more than once", async function () {
    const walletInstance = await SharedWallet.deployed();

    await walletInstance
    .initialize([deployer, owner], 1)
    .should.be.rejectedWith("Contract instance has already been initialized")
  });

});

