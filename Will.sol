// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

contract Will {
    address owner;
    uint fortune;
    bool isDeceased;
    address payable[] familyWallets;
    mapping(address => uint) inheritance;

    constructor() payable {
        owner = msg.sender;
        fortune = msg.value;
        isDeceased = false;
    }

    modifier onlyOnwer {
        require(msg.sender == owner);
        _;
    }

    modifier mustBeisDeceased {
        require(isDeceased == true);
        _;
    }

    function setInheritance(address payable wallet, uint amount) public onlyOnwer {
        familyWallets.push(wallet);
        inheritance[wallet] = amount;
    }

    function payout() private mustBeisDeceased {
        for (uint i=0; i < familyWallets.length; i++) {
            address payable wallet = familyWallets[i];
            wallet.transfer(inheritance[wallet]);
        }
    }

    function deceased() public onlyOnwer {
        isDeceased = true;
        payout();
    }

    function getFortune() public view returns (uint) {
        return fortune;
    }
}
