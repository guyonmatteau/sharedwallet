//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;
pragma experimental ABIEncoderV2;


contract SharedWallet {

    struct Transaction {
        address recipient;
        uint256 amount;
        uint256 votes;
    }

    // public mapping
    // we need to keep track of al pending transactions
    // and their number of votes in a mapping
    // mapping(address => Transaction) public pendingTransactions;

    bool private _initialized;
    address[] public owners;
    Transaction[] public pendingTransactions;

    // on deployment set owners that are allowed to vote
    // replaces constructor functionality (required due to Openzeppelin)
    function initialize(address[] memory _owners) public {
        require(
            !_initialized,
            "Contract instance has already been initialized"
        );
        _initialized = true;
        for (uint256 i = 0; i < _owners.length; i++) {
            owners.push(_owners[i]);
        }
    }

    function getOwners() public view retur  ns (address[] memory) {
        return owners;
    }

    function withdrawEther(address payable recipient, uint256 amount) public {
        recipient.transfer(amount);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // public function
    // submit transaction that adds to list
    // of pending transactions
    // requirement: be authorized
    function submitTransaction(address _recipient, uint256 _amount) public {
        Transaction memory transaction = Transaction({
            recipient: _recipient,
            amount: _amount,
            votes: 0
        });
        pendingTransactions.push(transaction);
    }

    function getTransactions() public view returns (Transaction[] memory) {
        return pendingTransactions;
    }

    receive() external payable {}

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
