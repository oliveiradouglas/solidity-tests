// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract Coin {
    address public owner;
    mapping(address => uint) public balances;
    event Sent(address from, address to, uint amount);
    error InsufficientBalance(uint requested, uint available);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function mint(address to, uint amount) public onlyOwner {
        balances[to] += amount;
    }

    function send(address receiver, uint amount) public {
        uint currentBalance = balances[msg.sender];
        if (currentBalance < amount) {
            revert InsufficientBalance(amount, currentBalance);
        }

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }

    function getValueInEth() public view returns(uint) {
        require(balances[msg.sender] > 0);
        // supose that coin correspond 80% of a ether
        uint convertionRatePct = 80;
        return (balances[msg.sender] * convertionRatePct) / 100;
    }
}
