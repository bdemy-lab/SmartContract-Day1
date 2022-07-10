// SPDX-License-Identifier: None
pragma solidity ^0.8.0;

contract Delegator {

    //  Running the contract with two cases:
    //  - With `result` 
    //  - Without `result` (comment out the variable `result`)
    uint256 public result;

    bytes4 public constant ADD_SELECTOR = bytes4(keccak256("add(uint256,uint256)"));
    bytes4 public constant GET_SELECTOR = bytes4(keccak256("result()"));

    function method1(address to, uint256 num1, uint256 num2) external {
        (bool success, ) = to.call(abi.encodeWithSignature("add(uint256,uint256)", num1, num2));

        require(success, "Failed");
    }

    function method2(address to, uint256 num1, uint256 num2) external {
        (bool success, ) = to.call(abi.encodeWithSelector(ADD_SELECTOR, num1, num2));

        require(success, "Failed");
    }

    function method3(address to, uint256 num1, uint256 num2) external {
        (bool success, ) = to.delegatecall(abi.encodeWithSignature("add(uint256,uint256)", num1, num2));

        require(success, "Failed");
    }

    function method4(address to, uint256 num1, uint256 num2) external {
        (bool success, ) = to.delegatecall(abi.encodeWithSelector(ADD_SELECTOR, num1, num2));

        require(success, "Failed");
    }

    function get1(address to) external view returns (uint256) {
        (bool success, bytes memory data) = to.staticcall(abi.encodeWithSignature("result()"));
        require(success, "Failed");

        return abi.decode(data, (uint256));
    }

    function get2(address to) external returns (uint256) {
        (bool success, bytes memory data) = to.delegatecall(abi.encodeWithSelector(GET_SELECTOR));
        require(success, "Failed");

        return abi.decode(data, (uint256));
    }
}