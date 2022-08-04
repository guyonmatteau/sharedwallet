//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;

// challenges 
// - people should not be able to vote twice
// - 

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

    bool private _initialized;

    address[] public owners;

    function initialize(address[] memory _owners) public {
        require(!_initialized, "Contract instance has already been initialized");
        _initialized = true;
        for (uint256 i = 0; i < _owners.length; i++) {
            owners.push(_owners[i]);
        }
    }

    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    function withdrawEther(address payable recipient, uint256 amount) public {
        recipient.transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    receive() external payable {}

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
