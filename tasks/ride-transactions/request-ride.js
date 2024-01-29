// Task to request a ride
task("request-ride", "Requests a ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("vehicletype", "The type of the vehicle")
  .addParam("pickuplatitude", "The latitude of the pickup location")
  .addParam("pickuplongitude", "The longitude of the pickup location")
  .addParam("destinationlatitude", "The latitude of the destination location")
  .addParam("destinationlongitude", "The longitude of the destination location")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const vehicleType = taskArgs.vehicletype;
    const pickUpLocation = { 
      latitude: parseInt(taskArgs.pickuplatitude), 
      longitude: parseInt(taskArgs.pickuplongitude) 
    };
    const destinationLocation = { 
      latitude: parseInt(taskArgs.destinationlatitude), 
      longitude: parseInt(taskArgs.destinationlongitude) 
    };

    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    await rideTransactions.requestRide(vehicleType, pickUpLocation, destinationLocation);
    console.log("Ride requested successfully");
  });

  module.exports = {};