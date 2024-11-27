// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Counter is Ownable {
    uint256 private number;

    constructor() Ownable(msg.sender) {}

    function getNumber() public view returns (uint256) {
        return number;
    }

    function setNumber(uint256 newNumber) public onlyOwner {
        number = newNumber;
    }

    function increment() public onlyOwner {
        number++;
    }

    receive() external payable {}
}
