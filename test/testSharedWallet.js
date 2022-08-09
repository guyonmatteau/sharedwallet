const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { expect, assert } = require("chai");
const lodash = require("lodash");
const { ethers, waffle } = require("hardhat");

contract("SharedWallet", (accounts) => {
    // Get the signer (Hardhat default)

    let deployedOwners = accounts.slice(0, 2);
    const nullAddress = "0x0000000000000000000000000000000000000000";

    // basic sanity tests
    it("should throw an error if any of the owners is the null address", async function () {
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

    // setup fixture for actual testing of methods
    async function deployContractFixture() {
        const SharedWallet = await ethers.getContractFactory("SharedWallet");
        const [owner1, owner2, recipient] = await ethers.getSigners();
        const requiredVotes = 1;
        const trxAmount = 200000; // Wei

        const walletInstance = await SharedWallet.deploy(
            [owner1.address, owner2.address],
            requiredVotes
        );
        await walletInstance.deployed();

        // deposit some ether
        await owner1.sendTransaction({
            to: walletInstance.address,
            value: ethers.utils.parseEther("5"),
        });

        // submit a transaction
        // const provider = waffle.provider;
        // const initialRecipientBalance = await provider.getBalance(recipient.address);
        // assert.equal(Number(initialRecipientBalance), 0);

        await walletInstance.submitTransaction(recipient.address, trxAmount);

        return { walletInstance, owner1, owner2, recipient, requiredVotes, trxAmount };
    }

    it("should set the owners correct", async function () {
        const { walletInstance, owner1, owner2 } = await loadFixture(deployContractFixture);

        // const SharedWallet = await ethers.getContractFactory("SharedWallet");
        // const walletInstance = await SharedWallet.deploy(deployedOwners, 1);
        const walletOwners = await walletInstance.getOwners();

        lodash.isEqual(walletOwners, [owner1.address, owner2.address]);
    });

    it("should submit the transaction", async function () {
        const { walletInstance, owner1, recipient } = await loadFixture(deployContractFixture);

        // await walletInstance.submitTransaction(recipient.address, 1);
        const { trxRecipient, amount, votes, executed } = await walletInstance.getTransaction(0);
        lodash.isEqual([trxRecipient, amount, votes, executed], [owner1.address, 1, 0, false]);
    });

    it("should execute transaction", async function () {
        const { walletInstance, owner1, recipient, trxAmount } = await loadFixture(
            deployContractFixture
        );

        const provider = waffle.provider;
        const initialRecipientBalance = await provider.getBalance(recipient.address);

        await walletInstance.connect(owner1).approveTransaction(0);
        const postTrxRecipientBalance = await provider.getBalance(recipient.address); // in Wei
        assert.notEqual(initialRecipientBalance, postTrxRecipientBalance);
    });

    it("should fail vote if sender already voted", async function () {
        const { walletInstance, owner1, recipient } = await loadFixture(deployContractFixture);
        await walletInstance.connect(owner1).approveTransaction(0);

        const { trxRecipient, amount, votes, executed } = await walletInstance.getTransaction(0);
        assert.equal(votes, 1);

        try {
            await walletInstance.connect(owner1).approveTransaction(0);
            assert.fail("sender not able to vote twice");
        } catch (err) {
            assert.include(err.message, "already", "Sender was able to vote twice");
        }
    });

    it("should fail vote if sender is not an owner", async function () {
        const { walletInstance, owner1, recipient } = await loadFixture(deployContractFixture);

        try {
            await walletInstance.connect(owner1).approveTransaction(0);
            assert.fail("sender is not an owner");
        } catch (err) {
            assert.include(err.message, "owner", "Sender was able to vote while no owner");
        }
    });
});
