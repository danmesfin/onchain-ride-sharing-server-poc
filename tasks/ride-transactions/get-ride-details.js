task("get-ride-details", "Gets the details of a specific ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideid", "The ID of the ride")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const rideId = taskArgs.rideid;
    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    const rideDetails = await rideTransactions.getRideDetails(rideId);
    console.log(`Ride Details: `, rideDetails);
  });

module.exports = {}