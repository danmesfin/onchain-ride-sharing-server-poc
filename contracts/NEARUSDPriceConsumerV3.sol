// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * @title The NEARUSDPriceConsumer contract
 * @notice A contract that returns the latest price from Chainlink Price Feeds for NEAR/USD
 */
contract NEARUSDPriceConsumer {
    AggregatorV3Interface internal immutable priceFeed;

    /**
     * @notice Executes once when a contract is created to initialize state variables
     *
     * @param _priceFeed - NEAR/USD Price Feed Address
     *
     * Note: Update the address below with the actual NEAR/USD price feed address for your network.
     */
    constructor(address _priceFeed) {
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    /**
     * @notice Returns the latest NEAR/USD price
     *
     * @return latest NEAR/USD price
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
     * @notice Returns the Price Feed address for NEAR/USD
     *
     * @return Price Feed address
     */
    function getPriceFeed() public view returns (AggregatorV3Interface) {
        return priceFeed;
    }
}
