const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory("irodoriNFT");
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to: ", nftContract.address);
    txn = await nftContract.createNFT("0.1", "1", "21");
    await txn.wait();
};

const runMain = async () => {
    try {
        await main();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain();