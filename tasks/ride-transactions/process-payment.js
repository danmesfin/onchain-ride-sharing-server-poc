task("process-payment", "Processes payment for a completed ride and allocates reward credits")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideid", "The ID of the ride")
  .addParam("user", "The address of the user")
  .addParam("distancetraveled", "The total distance traveled during the ride")
  .addParam("vehicletype", "The vehicle type as a bytes32 value")
  .addOptionalParam("value", "The payment amount in wei", "0", types.string)
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const rideId = taskArgs.rideid;
    const user = taskArgs.user;
    const distanceTraveled = taskArgs.distancetraveled;
    const vehicleType = taskArgs.vehicletype;
    const value = taskArgs.value;

    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    const transactionResponse = await rideTransactions.processPayment(rideId, user, distanceTraveled, hre.ethers.utils.formatBytes32String(vehicleType), { value: value });
    await transactionResponse.wait();

    console.log(`Payment processed for ride ID: ${rideId}`);
  });
