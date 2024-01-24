// scripts/deployRideTransactions.js

const { ethers } = require("hardhat");

async function deployRideTransactions(chainId) {
    const RideTransactions = await ethers.getContractFactory("RideTransactions");
    const rideTransactions = await RideTransactions.deploy();

    console.log(`RideTransactions deployed to: ${rideTransactions.address} on chain: ${chainId}`);
    return rideTransactions;
}

module.exports = { deployRideTransactions };
