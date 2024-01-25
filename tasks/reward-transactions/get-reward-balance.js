task("get-balance", "Gets the carbon credit balance of a user")
  .addParam("contract", "The address of the RewardTransactions contract")
  .addParam("user", "The address of the user")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const user = taskArgs.user;
    const rewardTransactions = await hre.ethers.getContractAt("RewardTransactions", contractAddr);
    const balance = await rewardTransactions.getBalance(user);
    console.log(`User ${user} has a balance of ${balance} credits`);
  });
