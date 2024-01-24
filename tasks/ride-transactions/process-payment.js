task("process-payment", "Processes payment for a completed ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideId", "The ID of the ride")
  .setAction(async (taskArgs, hre) => {
    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", taskArgs.contract);
    await rideTransactions.processPayment(taskArgs.rideId);
    console.log(`Payment processed for ride ID: ${taskArgs.rideId}`);
  });

module.exports = {}