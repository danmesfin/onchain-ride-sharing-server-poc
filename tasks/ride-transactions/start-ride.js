task("start-ride", "Starts a new ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("user", "The address of the user")
  .addParam("estimatedendtime", "The estimated end time of the ride")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const user = taskArgs.user;
    const estimatedEndTime = taskArgs.estimatedendtime;
    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    await rideTransactions.startRide( user, estimatedEndTime);
    console.log(`Ride started with ID: ${'TODO'}`);
  });

module.exports = {}