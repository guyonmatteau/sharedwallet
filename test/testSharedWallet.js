const { assert } = require("chai");
const lodash = require('lodash');

const SharedWallet = artifacts.require("SharedWallet");

contract("SharedWallet", (accounts) => {
  let deployedOwners = accounts.slice(0, 2);
  const nullAddress = "0x0000000000000000000000000000000000000000";

  it("should throw if any of the owners is the null address", async function () {
    const SharedWallet = await ethers.getContractFactory("SharedWallet");

    try {
      const walletInstance = await SharedWallet.deploy([nullAddress], 1);
      assert.fail("deployment should fail");
    } catch (err) {
      assert.include(
        err.message,
        "null",
        "Error message should contain null message information"
      );
    }
  });

  it("should throw an error if the min number of votes is smaller than 1", async function () {
    const SharedWallet = await ethers.getContractFactory("SharedWallet");

    try {
      const walletInstance = await SharedWallet.deploy(deployedOwners, 0);
      assert.fail("deployment should fail");
    } catch (err) {
      assert.include(
        err.message,
        "number of votes",
        "Error message should contain number of votes"
      );
    }
  });

  it("should set the owners properly", async function () {
    const SharedWallet = await ethers.getContractFactory("SharedWallet");
    const walletInstance = await SharedWallet.deploy(deployedOwners, 1);
    const walletOwners = await walletInstance.getOwners();

    lodash.isEqual(walletOwners, deployedOwners)
  });

});
