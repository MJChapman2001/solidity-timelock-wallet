// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract TimeLock {
    address owner;
    uint lock;
    uint start;

    constructor() {
        owner = msg.sender;
        // Change the time for the lock to last as long as you want
        lock = 20 seconds;
    }

    function Deposit() external payable {
        require(msg.sender == owner, "You cannot access this account");
        start = block.timestamp;
    }

    function Withdraw() public {
        require(msg.sender == owner, "You cannot access this account");
        require(block.timestamp >= (start + lock), "Too early");
        payable(owner).transfer(address(this).balance);
    }

    function Balance() public view returns(uint) {
        return address(this).balance;
    }
}