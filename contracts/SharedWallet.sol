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
        for (uint i = 0; i < _owners.length; i++) {
            owners.push(_owners[i]);
        }
    }

    function getOwners() public view returns (address[] memory) {
        return owners;
    }

    function withdrawEther(address payable recipient, uint amount) public {
        recipient.transfer(amount);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // public function
    // submit transaction that adds to list
    // of pending transactions
    // requirement: be authorized
    function submitTransaction(address _recipient, uint _amount) public {
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

    receive() external payable {
    }

    // public function
    // vote for certain transaction,
    // if number of votes is equal to min number of votes,
    // execute transaction
    // requirement: be authorized
    function voteTransaction(address _recipient) public {
        for (uint i = 0; i < pendingTransactions.length; i++) {
            if (pendingTransactions[i].recipient == _recipient){
                pendingTransactions[i].votes ++;
            }
        }
    }

    // get vote count for certain transaction     
    function getVotes(address _recipient) public view returns (uint) {
        uint voteCount;
        for (uint i = 0; i < pendingTransactions.length; i++) {
            if (pendingTransactions[i].recipient == _recipient){
                voteCount = pendingTransactions[i].votes;
            }
        }
        return voteCount;
    }

    // public function
    // revoke vote for certain transaction
    // requirement: only be able to revoke own vote
    // reuquirment: be authorized

    // private function
    // execute transaction
    function _executeTransaction(address payable _recipient, uint _amount) private {
        _recipient.transfer(_amount);
    }

}
