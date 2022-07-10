const dotenv = require("dotenv");
dotenv.config({ path: __dirname + "/.env" });

require("@nomiclabs/hardhat-ethers");

const mnemonic = process.env.MNEMONIC

module.exports = {
    solidity: {
        compilers: [
            {
                version: "0.8.6"
            }
        ]
    },

    gasReporter: {
        enabled: true
    },

    networks: {
        development: {
            url: "http://127.0.0.1:8545",     // Localhost (default: none)
            accounts: {
                mnemonic: mnemonic,
                count: 10
            },
            live: false, 
            saveDeployments: true
        },
        testnet: {
            url: process.env.BSC_TESTNET_PROVIDER,
            accounts: [
                process.env.TESTNET_DEPLOYER,
                process.env.TESTNET_DEPLOYER2
            ],
            timeout: 20000,
            chainId: 97,
        },
    },

    paths: {
        sources: "./contracts",
        tests: "./test",
        cache: "./build/cache",
        artifacts: "./build/artifacts",
        deployments: "./deployments"
    },
}