task("redeem-credit", "Allows a user to redeem their credits")
  .addParam("contract", "The address of the RewardTransactions contract")
  .addParam("credits", "The amount of credits to redeem")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const credits = taskArgs.credits;
    const rewardTransactions = await hre.ethers.getContractAt("RewardTransactions", contractAddr);
    await rewardTransactions.redeemCredits(credits);
    console.log(`Credits redeemed: ${credits}`);
  });
