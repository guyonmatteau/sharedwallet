//"SPDX-License-Identifier: UNLICENSED"
pragma solidity ^0.6.3;

import "../contracts/MyMapping.sol";
import "forge-std/Test.sol";

contract MyMappingTest is Test {

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
