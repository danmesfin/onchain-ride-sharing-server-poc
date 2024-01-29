// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title The AVAXNEARPriceConsumer contract
 * @notice A contract that returns the latest price from Chainlink Price Feeds for AVAX/NEAR
 */
contract AVAXNEARPriceConsumer {
    AggregatorV3Interface internal immutable priceFeed;

    /**
     * @notice Executes once when a contract is created to initialize state variables
     *
     * param _priceFeed - AVAX/NEAR Price Feed Address
     * 
     * Note: Update the address below with the actual AVAX/NEAR price feed address for your network.
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0x5498BB86BC934c8D34FDA08E81D444153d0D06aD);
    }

    /**
     * @notice Returns the latest AVAX/NEAR price
     *
     * @return latest AVAX/NEAR price
     */
    function getLatestPrice() public view returns (int256) {
        (
            /*uint80 roundID*/,
            int256 price,
            /*uint256 startedAt*/,
            /*uint256 timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }

    /**
     * @notice Returns the Price Feed address for AVAX/NEAR
     *
     * @return Price Feed address
     */
    function getPriceFeed() public view returns (AggregatorV3Interface) {
        return priceFeed;
    }
}
