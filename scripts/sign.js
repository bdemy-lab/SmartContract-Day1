const { ethers } = require("hardhat");

function sign(signer, contract, selector, beneficiary, amount) {
    let message = ethers.utils.solidityKeccak256(
        ['address', 'bytes4', 'address', 'uint256'],
        [contract, selector, beneficiary, amount]
    );

    return signer.signMessage(ethers.utils.arrayify(message));   
}

async function main() {
    const [signer1, signer2] = await ethers.getSigners();

    const addr = '';              //  Replace by deployed contract address on Remix
    const selector = '0x38926b6d';
    const beneficiary = '0x5B38Da6a701c568545dCfcB03FcB875f56beddC4';       //  Check Default Account on Remix, and replace yours
    const amount = 1000;          //  Replace a different amount if needed

    const signature = await sign(signer1, addr, selector, beneficiary, amount);
    console.log(signature);

    console.log('\n===== DONE =====')
}
  
main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
});