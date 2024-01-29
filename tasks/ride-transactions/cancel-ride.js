task("cancel-ride", "Cancels a ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideid", "The ID of the ride")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const rideId = taskArgs.rideid;

    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    await rideTransactions.cancelRide(rideId);
    console.log("Ride cancelled successfully");
  });

  module.exports = {};