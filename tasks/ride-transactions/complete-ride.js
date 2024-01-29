task("complete-ride", "Completes a ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideid", "The ID of the ride")
  .addParam("distance", "The distance traveled during the ride")
  .addParam("destinationlatitude", "The latitude of the destination location")
  .addParam("destinationlongitude", "The longitude of the destination location")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const rideId = taskArgs.rideid;
    const distance = taskArgs.distance;
    const destinationLocation = { 
      latitude: parseInt(taskArgs.destinationlatitude), 
      longitude: parseInt(taskArgs.destinationlongitude) 
    };

    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    await rideTransactions.completeRide(rideId, distance, destinationLocation);
    console.log("Ride completed successfully");
  });

  module.exports = {};