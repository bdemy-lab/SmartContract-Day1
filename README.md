## Learning Smart Contract - Day 1

### Call vs Delegatecall vs Staticcall

- Please read this document to understand concept of `Call` and `Delegatecall` [[link](https://medium.com/coinmonks/delegatecall-calling-another-contract-function-in-solidity-b579f804178c)]

- For better understanding, a simple example is provided for experiment. You can run these contracts on Remix using its testing environment
    - `Delegatee.sol`: a simple contract to be called by another contract. 
        - Adding two numbers
        - Save the result into a contract state variable `result`
    - `Delegator.sol`: a simple contract calls another contract using three mechanisms `staticcall`, `call`, and `delegatecall`

- Two testing cases:
    - `result` is defined in the `Delegator.sol`
    - Comment out `result` and leave it undefine in the `Delegator.sol`

- Once you have done running an experiment and understood the concept of `delegatecall`, you can try to look further use case of using `delegatecall`, `Proxy Design Pattern`, that supports a feature of contract upgradeability ([[link](https://blog.openzeppelin.com/proxy-patterns/)] and [[link](https://docs.openzeppelin.com/upgrades-plugins/1.x/proxies#unstructured-storage-proxies)])

### Signature Replay Attack

- To demonstrate a concept of Double Spending, `Signature Replay Attack` will be used. This attack is commonly occurred when there is a gap of handling between the Back-end and the Smart Contract

- There are two possible situations that `Signature Replay Attack` can be exploited
    - Only one Authorizer scheme: a signature is not recorded after used (`claim1()`)
    - Multiple Authorizers scheme: signatures are recorded after used, but one request can be signed by multiple Authorizers (`claim2()`)
- There are several solutions. One of them is provided in the example code (`claim3()`)

- How to generate a signature?
    - Check `env.example` to create `.env` file in your folder
    - Add your private key of two accounts `TESTNET_DEPLOYER` and `TESTNET_DEPLOYER2`
    - Check `scripts/sign.js` and provided an address of deployed contract on Remix
    - Run `yarn sign`. Note you can modify this script to generate different signatures for the experiment