pragma solidity ^0.5.0;

import './SafeMath.sol';

contract DeadManSwitch {

    using SafeMath for uint;

    address public owner;
    address public nextOwner;
    uint public lastBlock;
    bool public isOwnerAlive;

    event OwnerDead();

    constructor (address _nextOwner) public {
        require(_nextOwner != msg.sender, "What will you do with money after you're dead?");
        owner = msg.sender;
        nextOwner = _nextOwner;
        lastBlock = block.number;
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

    function isAlive() public onlyOwner {
        require(isOwnerAlive, "Can't come back from the dead, can you?");
        lastBlock = block.number;
        isOwnerAlive = true;
    }

    function getOwnerBalance() public view onlyFutureOwner returns (uint) {
        return owner.balance;
    }

    function isOwnerDead() public onlyFutureOwner returns (uint) {
        require(block.number.sub(lastBlock) > 10, "The owner is still alive!");
        isOwnerAlive = false;
        emit OwnerDead();
        return owner.balance;
    }
}