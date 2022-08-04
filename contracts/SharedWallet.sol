//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;

contract SharedWallet {

    // events for returning useful stuff for user
    // is like console.log
    // event pendingTransaction(address indexed sender, uint amount);

    // struct transaction
    // we need a struct for a transaction
    // struct Transaction {
    //     address recipient;
    //     uint256 amount;
    //     uint256 votes;
    // }

    // public mapping
    // we need to keep track of al pending transactions
    // and their number of votes in a mapping
    // mapping(address => Transaction) public pendingTransactions;

    // helper method to get transactions
    // function getTransaction() external {
    //     uint amount = 2;
    //     emit pendingTransaction(msg.sender, amount);
    // }
    
    // function myFunction() public pure returns (uint) {
    //     uint val = 2;
    //     return val;
    // }

    function withdrawEther(address payable recipient, uint amount) public {
        recipient.transfer(amount);
    } 

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    receive() external payable {
    }



    // construct
    // during the contruct set owner,
    // number of members,
    // minimum number of approvals

    // public function
    // submit transaction that adds to list
    // of pending transactions
    // requirement: be authorized

    // public function
    // vote for certain transaction,
    // if number of votes is equal to min number of votes,
    // execute transaction
    // requirement: be authorized

    // public function
    // revoke vote for certain transaction
    // requirement: only be able to revoke own vote
    // reuquirment: be authorized

    // private function
    // execute transaction
}
