task("set-emission-factor", "Sets the emission factor for a vehicle type")
  .addParam("contract", "The address of the RewardTransactions contract")
  .addParam("vehicletype", "The vehicle type as a bytes32 value")
  .addParam("emissionfactor", "The emission factor")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const vehicleType = taskArgs.vehicletype;
    const emissionFactor = taskArgs.emissionfactor;
    const rewardTransactions = await hre.ethers.getContractAt("RewardTransactions", contractAddr);
    await rewardTransactions.setEmissionFactor(hre.ethers.utils.formatBytes32String(vehicleType), emissionFactor);
    console.log(`Emission factor set for vehicle type ${vehicleType}`);
  });
