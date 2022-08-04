//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;

contract MappingStruct {
    struct Payment {
        uint256 amount;
        uint256 timestamp;
    }

    struct Balance {
        uint256 totalBalance;
        uint256 numPayment;
        mapping(uint256 => Payment) payments;
    }

    mapping(address => Balance) public balanceReceived;

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value;
    }

    function getValue() public pure returns (uint256) {
        uint256 val = 2;
        return val;
    }
}
