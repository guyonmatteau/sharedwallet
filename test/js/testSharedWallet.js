const SharedWallet = artifacts.require("SharedWallet");

contract("MappingStruct", accounts => {
    it("... should do this", async function () {
    const mappingInstance = await MappingStruct.deployed();
    const mappingValue = 2;
    
    const value = await mappingInstance.getValue();
    assert.equal(value, mappingValue, "Values don't match");
    });
})

