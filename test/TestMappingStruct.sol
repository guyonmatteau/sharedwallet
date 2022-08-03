//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;

import "truffle/Assert.sol";
import "../contracts/MappingStruct.sol";

contract TestMyMapping {

    MyMapping m;

    function _beforeAll() public {
        // create new instance of contract
        m = new MyMapping();
    }

    uint val = 2;
    function testGetValue() public {
        // assert that given x, value is 2
        Assert.equal(m.getValue(), val, "Value is not 2");
    }

}
