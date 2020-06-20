const DeadManSwitch = artifacts.require('DeadManSwitch');

module.exports = (deployer) => {
    // const newOwner = '0xAfE237f410a45ED5cEF2BEEC872376A9b997C875';                  // Add beneficiary address here!
    const newOwner = '0x73B1b5EB3EDAf399333686EE57789f3c24b48007';                  // Add beneficiary address here!
    deployer.deploy(DeadManSwitch, newOwner);
}