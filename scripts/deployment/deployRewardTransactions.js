// scripts/deployRideTransactions.js

const { ethers } = require("hardhat");

async function deployRewardTransactions(chainId) {
    const RewardTransactions = await ethers.getContractFactory("RewardTransactions");
    const rewardTransactions = await RewardTransactions.deploy();

    console.log(`Reward Contract deployed to: ${rewardTransactions.address} on chain: ${chainId}`);
    return rewardTransactions;
}

module.exports = { deployRewardTransactions };
