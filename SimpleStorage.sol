// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 < 0.9.0;

contract SimpleStorage {
    uint storedData;

    function set(uint amount) public {
        storedData = amount;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}