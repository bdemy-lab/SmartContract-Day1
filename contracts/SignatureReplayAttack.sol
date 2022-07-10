// SPDX-License-Identifier: None
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

/*
    -  This contract helps to demonstrate concept of Double Spending
        via using Signature Replay Attack scheme
*/
contract SignatureReplayAttack {

    address public authorizer;
    bytes4 public constant SELECTOR = bytes4(keccak256("claim(uint256,bytes)"));

    mapping(address => bool) public authorizers;
    mapping(bytes32 => bool) public used;
    mapping(address => uint256) public nonces;

    constructor(address authorizer_) {
        authorizer = authorizer_;
    }

    function setAuthorizer(address authorizer_) external {
        authorizers[authorizer_] = true;
    }

    //  deposit native coin to the contract
    function deposit() external payable {}

    //  An example of Signature Replay Attack
    function claim1(uint256 amount, bytes calldata signature) external {
        bytes32 msgHash = ECDSA.toEthSignedMessageHash(
            keccak256(
                abi.encodePacked(address(this), SELECTOR, msg.sender, amount)
            )
        );
        require(ECDSA.recover(msgHash, signature) == authorizer, "Invalid signature");

        Address.sendValue(payable(msg.sender), amount);
    }

    //  Another example of Signature Replay Attack
    function claim2(uint256 amount, bytes calldata signature) external {
        bytes32 hash = keccak256(signature);
        require(
            !used[hash], "Signature has been used"
        );

        bytes32 msgHash = ECDSA.toEthSignedMessageHash(
            keccak256(
                abi.encodePacked(address(this), SELECTOR, msg.sender, amount)
            )
        );
        require(
            authorizers[ECDSA.recover(msgHash, signature)], "Invalid signature"
        );

        used[hash] = true;

        Address.sendValue(payable(msg.sender), amount);
    }

    //  Solution: adding nonce into a message hash to be signed by Authorizer
    //  Nonce is increased when a request is executed successfully
    //  A signature, that Authorizer previously signs on old nonces, is automatically deprecated
    //  regardless of whether a signature has been redeemed or not
    //  Thus, contract does not need to record these signatures
    function claim3(uint256 amount, bytes calldata signature) external {
        bytes32 msgHash = ECDSA.toEthSignedMessageHash(
            keccak256(
                abi.encodePacked(address(this), SELECTOR, msg.sender, nonces[msg.sender], amount)
            )
        );
        require(
            authorizers[ECDSA.recover(msgHash, signature)], "Invalid signature"
        );
        nonces[msg.sender]++;

        Address.sendValue(payable(msg.sender), amount);
    }

    function balance(address account) external view returns (uint256) {
        return account.balance;
    }
}