task("get-emission-factor", "Gets the emission factor for a vehicle type")
  .addParam("contract", "The address of the RewardTransactions contract")
  .addParam("vehicletype", "The vehicle type as a bytes32 value")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const vehicleType = taskArgs.vehicletype;
    const rewardTransactions = await hre.ethers.getContractAt("RewardTransactions", contractAddr);
    const emissionFactor = await rewardTransactions.getEmissionFactor(hre.ethers.utils.formatBytes32String(vehicleType));
    console.log(`Emission factor for vehicle type ${vehicleType} is ${emissionFactor}`);
  });
