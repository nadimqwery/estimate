const Estimate = artifacts.require("./Estimate.sol");
module.exports = function (deployer) {
    deployer.deploy(Estimate);
};