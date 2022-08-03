const MappingStruct = artifacts.require("MappingStruct");

module.exports = function (deployer) {
  deployer.deploy(MappingStruct);
};
