task("process-payment", "Processes payment for a ride")
  .addParam("contract", "The address of the RideTransactions contract")
  .addParam("rideid", "The ID of the ride")
  .setAction(async (taskArgs, hre) => {
    const contractAddr = taskArgs.contract;
    const rideId = taskArgs.rideid;

    const rideTransactions = await hre.ethers.getContractAt("RideTransactions", contractAddr);
    await rideTransactions.processPayment(rideId);
    console.log("Payment processed successfully");
  });

  module.exports = {};