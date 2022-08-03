//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;

import "./MyMapping.sol";
import "@mangrovedao/hardhat-test-solidity/test.sol";

contract MyMappingTest {

    MyMapping m;

    function _beforeAll() public {
        // create new instance of contract
        m = MyMapping();
    }

    function getValue_test() public {
        // assert that given x, value is 2
        Assert.equal(m.getValue(), 2, "Value is not 2");
    }

}
