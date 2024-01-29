async function main() {
    const [deployer] = await ethers.getSigners();
    
    console.log("Deploying contracts with the account:", deployer.address);
  
    const NEARUSDPriceConsumer = await ethers.getContractFactory("NEARUSDPriceConsumer");
    const nearUsdPriceConsumer = await NEARUSDPriceConsumer.deploy(priceFeedAddress);
  
    console.log("NEAR/USD Price Consumer address:", nearUsdPriceConsumer.address);
  }
  
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
    });
  