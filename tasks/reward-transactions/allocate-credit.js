task("allocate-credit", "Allocates credits to a user after a ride")
  .addParam("contract", "The address of the RewardTransactions contract")
  .addParam("user", "The address of the user")
  .addParam("distancetraveled", "The distance traveled")
  .addParam("vehicletype", "The vehicle type as a bytes32 value")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const user = taskArgs.user;
    const distanceTraveled = taskArgs.distancetraveled;
    const vehicleType = taskArgs.vehicletype;
    const rewardTransactions = await hre.ethers.getContractAt("RewardTransactions", contractAddr);
    await rewardTransactions.allocateCredits(user, distanceTraveled, hre.ethers.utils.formatBytes32String(vehicleType));
    console.log(`Credits allocated to ${user}`);
  });
