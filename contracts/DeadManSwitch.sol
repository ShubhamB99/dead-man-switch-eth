pragma solidity ^0.5.0;

import './SafeMath.sol';

contract DeadManSwitch {

    using SafeMath for uint;

    address owner;
    address nextOwner;
    uint lastBlock;
    uint ownerBalance;
    bool isOwnerAlive;

    event SuccessfulTransfer(uint amount);

    constructor (address _nextOwner) public {
        require(_nextOwner != msg.sender, "Too smart xP!");
        owner = msg.sender;
        nextOwner = _nextOwner;
        lastBlock = block.number;
        ownerBalance = owner.balance;
        isOwnerAlive = true;
    }

    modifier onlyOwner () {
        require(msg.sender == owner, "You need to be owner to call this function!");
        _;
    }

    modifier onlyFutureOwner () {
        require(msg.sender == nextOwner, "You need to be the future owner to call this function!");
        _;
    }

    function () external payable {
    }

    function isAlive() public onlyOwner {
        lastBlock = block.number;
        isOwnerAlive = true;
    }

    function getOriginalBalance() public view onlyFutureOwner returns (uint) {
        return ownerBalance;
    }

    function getNewBalance() public view onlyFutureOwner returns (uint) {
        return nextOwner.balance;
    }

    function transferFunds() public onlyFutureOwner {
        uint currentBlock = block.number;
        require(currentBlock.sub(lastBlock) > 10, "The owner is still alive!");
        isOwnerAlive = false;
        (bool transferred, ) = msg.sender.call.value(ownerBalance)("");
        require(transferred, "Transfer of money failed.");
        emit SuccessfulTransfer(ownerBalance);
    }
}