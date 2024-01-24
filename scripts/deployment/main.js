const { network, run } = require("hardhat");

const { deployApiConsumer } = require("./deployApiConsumer");
const { deployAutomationCounter } = require("./deployAutomationCounter");
const { deployPriceConsumerV3 } = require("./deployPriceConsumerV3");
const { deployRandomNumberConsumer } = require("./deployRandomNumberConsumer");
const {
    deployRandomNumberDirectFundingConsumer,
} = require("./deployRandomNumberDirectFundingConsumer");
const { deployRideTransactions } = require("./deployRideTransactions"); // Import the new deployment function
const { deployRewardTransactions } = require("./deployRewardTransactions");

async function main() {
    await run("compile");
    const chainId = network.config.chainId;

    // await deployApiConsumer(chainId);
    // await deployAutomationCounter(chainId);
    // await deployPriceConsumerV3(chainId);
    // await deployRandomNumberConsumer(chainId);
    // await deployRandomNumberDirectFundingConsumer(chainId);
    await deployRideTransactions(chainId);
    await deployRewardTransactions(chainId);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
