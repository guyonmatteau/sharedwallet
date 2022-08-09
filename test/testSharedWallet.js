const { assert } = require("chai");
const lodash = require("lodash");

const SharedWallet = artifacts.require("SharedWallet");

contract("SharedWallet", (accounts) => {
    // Get the signer (Hardhat default)
    const [sender] = await ethers.getSigners();

    let deployedOwners = accounts.slice(0, 2);
    const nullAddress = "0x0000000000000000000000000000000000000000";

    // basic sanity tests
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

    it("should set the owners correct", async function () {
        const SharedWallet = await ethers.getContractFactory("SharedWallet");
        const walletInstance = await SharedWallet.deploy(deployedOwners, 1);
        const walletOwners = await walletInstance.getOwners();

        lodash.isEqual(walletOwners, deployedOwners);
    });

    it("should not be possible to vote twice", async function () {
        const SharedWallet = await ethers.getContractFactory("SharedWallet");
        const walletInstance = await SharedWallet.deploy(deployedOwners, 1);

        await walletInstance.transfer(deployedOwners[0], walletInstance.address);
        walletInstance.submitTransaction(accounts[3], 1);

    });
});
