task("set-cost-per-unit", "Sets the cost per unit for rides")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("costperunit", "The cost per unit to set")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const costPerUnit = taskArgs.costperunit;

    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    await rideTransactions.setCostPerUnit(costPerUnit);
    console.log("Cost per unit set to:", costPerUnit);
  });
  module.exports = {};