// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CarbonCreditRewards {
    uint256 private constant SCALE = 1e18;

    // Mapping from vehicle type to its emission factor (CO2 emitted per unit distance)
    mapping(bytes32 => uint256) public emissionFactors;

    // Mapping from user address to their carbon credit balance
    mapping(address => uint256) public balances;

     // Events
    event CreditsAllocated(address indexed user, uint256 credits);
    event CreditsRedeemed(address indexed user, uint256 credits);

    // Function to set the emission factor for a vehicle type
    function setEmissionFactor(bytes32 _vehicleType, uint256 _emissionFactor) external {
        emissionFactors[_vehicleType] = _emissionFactor;
    }

    // Function to calculate and assign carbon credits to a user after a ride
    function allocateCredits(
        address _user,
        uint256 _distanceTraveled,
        bytes32 _vehicleType
    ) external {
        uint256 emissionFactor = emissionFactors[_vehicleType];
        require(emissionFactor > 0, "Emission factor not set for vehicle type");

        // Calculate the amount of CO2 offset based on the distance and emission factor
        // Typically, less CO2 emissions will result in more credits being earned
        uint256 credits = (_distanceTraveled * SCALE) / emissionFactor;

        // Update the user's balance
        balances[_user] += credits;

        emit CreditsAllocated(_user, credits);
    }

    // Function for users to redeem their credits
    function redeemCredits(uint256 _credits) external {
        require(balances[msg.sender] >= _credits, "Insufficient credit balance");

        // Deduct the credits from the user's balance
        balances[msg.sender] -= _credits;

        // Implement the logic for redemption
        // For example, this could involve sending a token, updating a state, etc.

        emit CreditsRedeemed(msg.sender, _credits);
    }

    // Function to view the carbon credit balance of a user
    function getBalance(address _user) external view returns (uint256) {
        return balances[_user];
    }

    // Function to view the emission factor of a vehicle type
    function getEmissionFactor(bytes32 _vehicleType) external view returns (uint256) {
        return emissionFactors[_vehicleType];
    }
}