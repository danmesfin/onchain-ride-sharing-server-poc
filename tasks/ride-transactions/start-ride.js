task("start-ride", "Starts a new ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideId", "The ID of the ride")
  .addParam("user", "The address of the user")
  .addParam("estimatedEndTime", "The estimated end time of the ride")
  .setAction(async (taskArgs, hre) => {
    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", taskArgs.contract);
    await rideTransactions.startRide(taskArgs.rideId, taskArgs.user, taskArgs.estimatedEndTime);
    console.log(`Ride started with ID: ${taskArgs.rideId}`);
  });

module.exports = {}