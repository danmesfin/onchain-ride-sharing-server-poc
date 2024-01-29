// Task to start a ride
task("start-ride", "Starts a ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("user", "The address of the user requesting the ride")
  .addParam("pickuplatitude", "The latitude of the pickup location")
  .addParam("pickuplongitude", "The longitude of the pickup location")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const user = taskArgs.user;
    const pickUpLocation = { 
      latitude: parseInt(taskArgs.pickuplatitude), 
      longitude: parseInt(taskArgs.pickuplongitude) 
    };

    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    await rideTransactions.startRide(user, pickUpLocation);
    console.log("Ride started successfully");
  });
  module.exports = {};