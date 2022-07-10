// SPDX-License-Identifier: None
pragma solidity ^0.8.0;

contract Delegatee {
    uint256 public result;

    function add(uint256 num1, uint256 num2) external {
        result = num1 + num2;
    }
}