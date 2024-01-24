task("complete-ride", "Completes a ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideid", "The ID of the ride")
  .addParam("distance", "The total distance traveled during the ride")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const rideId = taskArgs.rideid;
    const distance = taskArgs.distance;
    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    await rideTransactions.completeRide(rideId, distance);
    console.log(`Ride completed with ID: ${rideId}`);
  });

module.exports = {}