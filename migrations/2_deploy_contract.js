const DeadManSwitch = artifacts.require('DeadManSwitch');

module.exports = (deployer) => {
    const newOwner = '0x..';                  // Add beneficiary address here!
    deployer.deploy(DeadManSwitch, newOwner);
}