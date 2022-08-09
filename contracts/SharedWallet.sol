//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;
pragma experimental ABIEncoderV2;

contract SharedWallet {
    // TODO currently it only supports 1 transaction per recipient
    struct Transaction {
        address recipient;
        uint256 amount;
        uint256 votes;
        bool executed;
        mapping(address => bool) approvals;
    }

    // on a local testnet it's hard to get the logs
    event Deposit(address indexed _sender, uint256 indexed _amount);

    uint256 public minVotes;
    address[] public owners;
    Transaction[] public pendingTransactions;

    // mapping can be used as convenient list
    mapping(address => bool) public isOwner;

    constructor(address[] memory _owners, uint256 _minVotes) public {
        require(_minVotes > 0, "Minimal number of votes cannot be 0");
        minVotes = _minVotes;
        
        // add owners to owners list
        for (uint256 i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "Owner address cannot be null address");
            isOwner[owner] = true;

            // keep track of owners
            owners.push(owner);
        }
    }

    // public function
    // submit transaction that adds to list
    // of pending transactions
    // requirement: be authorized
    function submitTransaction(address _recipient, uint256 _amount) public {
        Transaction memory transaction = Transaction({
            recipient: _recipient,
            amount: _amount,
            votes: 0,
            executed: false
        });
        pendingTransactions.push(transaction);
    }

    // public function
    // vote for certain transaction,
    // if number of votes is equal to min number of votes,
    // execute transaction
    // requirement: be authorized
    function approveTransaction(address _recipient) public {
        require(isOwner[msg.sender], "Sender is not owner");
        for (uint256 i = 0; i < pendingTransactions.length; i++) {
            if (
                pendingTransactions[i].recipient == _recipient &&
                !pendingTransactions[i].approvals[msg.sender]
            ) {
                // this can be done smarter
                pendingTransactions[i].votes++;
                pendingTransactions[i].approvals[msg.sender] = true;
                if (
                    pendingTransactions[i].votes >= minVotes &&
                    !pendingTransactions[i].executed
                ) {
                    pendingTransactions[i].executed = true;
                    _executeTransaction(
                        payable(pendingTransactions[i].recipient),
                        pendingTransactions[i].amount
                    );
                }
            }
        }
    }

    // public function
    // revoke vote for certain transaction
    // requirement: only be able to revoke own vote
    // reuquirment: be authorized
    function revokeApproval(address _recipient) public {
        require(isOwner[msg.sender], "Sender is not owner");
        for (uint256 i = 0; i < pendingTransactions.length; i++) {
            if (
                pendingTransactions[i].recipient == _recipient &&
                pendingTransactions[i].approvals[msg.sender]
            ) {
                // this can be done smarter
                pendingTransactions[i].votes--;
                pendingTransactions[i].approvals[msg.sender] = false;
            }
        }
    }

    receive() external payable {
        emit Deposit({_sender: msg.sender, _amount: msg.value});
    }

    // private function
    // execute transaction
    function _executeTransaction(address payable _recipient, uint256 _amount)
        private
    {
        _recipient.transfer(_amount);
    }

    // utility methods

    // get vote count for certain transaction
    function getVotes(address _recipient) public view returns (uint256) {
        uint256 voteCount;
        for (uint256 i = 0; i < pendingTransactions.length; i++) {
            if (pendingTransactions[i].recipient == _recipient) {
                voteCount = pendingTransactions[i].votes;
            }
        }
        return voteCount;
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

    // function getTransactions() public view returns (Transaction[] memory) {
    //     return pendingTransactions;
    // }
}
