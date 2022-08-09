//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;
pragma experimental ABIEncoderV2;

contract SharedWallet {
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
    Transaction[] public transactions;

    // mapping can be used as convenient list
    mapping(address => bool) public isOwner;

    constructor(address[] memory _owners, uint256 _minVotes) public {
        require(_minVotes > 0, "Minimal number of votes cannot be 0");
        require(
            _minVotes <= _owners.length,
            "Number of minimum votes should be smaller or equal to number of owners"
        );
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
        Transaction memory trx = Transaction({
            recipient: _recipient,
            amount: _amount,
            votes: 0,
            executed: false
        });
        transactions.push(trx);
    }

    // public function to vote for transaction
    // if number of votes is equal to min number of votes,
    // execute transaction
    function approveTransaction(uint256 _index) public {
        require(isOwner[msg.sender], "Sender is not owner");
        require(transactions[_index].approvals[msg.sender] == false, "Sender already voted");

        // vote and set approval
        transactions[_index].votes++;
        transactions[_index].approvals[msg.sender] = true;

        // execute transaction if sufficient votes
        if (transactions[_index].votes >= minVotes && !transactions[_index].executed) {
            _executeTransaction(_index);
        }
    }

    // public function
    // revoke vote for certain transaction
    // requirement: only be able to revoke own vote
    // reuquirment: be authorized
    function revokeApproval(address _recipient) public {
        require(isOwner[msg.sender], "Sender is not owner");
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].recipient == _recipient && transactions[i].approvals[msg.sender]) {
                // this can be done smarter
                transactions[i].votes--;
                transactions[i].approvals[msg.sender] = false;
            }
        }
    }

    receive() external payable {
        emit Deposit({_sender: msg.sender, _amount: msg.value});
    }

    // private function to execute transactions
    function _executeTransaction(uint256 _index) private {
        Transaction memory trx = transactions[_index];
        address payable _recipient = payable(trx.recipient);
        uint _amount = trx.amount;
        require(trx.executed == false); // not really needed?

        transactions[_index].executed = true;
        _recipient.transfer(_amount);
    }

    // utility methods

    // get vote count for certain transaction
    function getVotes(address _recipient) public view returns (uint256) {
        uint256 voteCount;
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].recipient == _recipient) {
                voteCount = transactions[i].votes;
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

    function getTransaction(uint256 _index)
        public
        view
        returns (
            address recipient,
            uint256 amount,
            uint256 votes,
            bool executed
        )
    {
        Transaction memory trx = transactions[_index];
        return (trx.recipient, trx.amount, trx.votes, trx.executed);
    }
}
