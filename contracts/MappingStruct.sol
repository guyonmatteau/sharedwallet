//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;

contract MappingStruct {

    struct Payment {
        uint amount;
        uint timestamp;
    }
    
    struct Balance {
        uint totalBalance;
        uint numPayment;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) public balanceReceived;
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function sendMoney() public payable {
        
        balanceReceived[msg.sender].totalBalance += msg.value;

    }

    function getValue() public pure returns(uint) {
        uint val = 2;
        return val;
    }

}