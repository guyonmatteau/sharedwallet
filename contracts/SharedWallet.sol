//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;

contract SharedWallet {
    
    // struct transaction
    // we need a struct for a transaction

    // public mapping
    // we need to keep track of al pending transactions
    // and their number of votes in a mapping
    
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