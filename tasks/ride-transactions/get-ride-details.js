task("get-ride-details", "Gets the details of a specific ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideId", "The ID of the ride")
  .setAction(async (taskArgs, hre) => {
    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", taskArgs.contract);
    const rideDetails = await rideTransactions.getRideDetails(taskArgs.rideId);
    console.log(`Ride Details: `, rideDetails);
  });

module.exports = {}