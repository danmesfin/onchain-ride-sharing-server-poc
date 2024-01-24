task("complete-ride", "Completes a ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideId", "The ID of the ride")
  .addParam("distance", "The total distance traveled during the ride")
  .setAction(async (taskArgs, hre) => {
    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", taskArgs.contract);
    await rideTransactions.completeRide(taskArgs.rideId, taskArgs.distance);
    console.log(`Ride completed with ID: ${taskArgs.rideId}`);
  });

module.exports = {}