const SharedWallet = artifacts.require("SharedWallet");

contract("SharedWallet", accounts => {
    it("... should do this", async function () {
    const walletInstance = await SharedWallet.deployed();
    
    // const value = await walletInstance.getValue();
    assert.equal(2, 2, "Values don't match");
    });
})

