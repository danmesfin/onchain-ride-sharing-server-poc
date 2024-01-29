// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RewardTransactions {
    address public owner;
    uint256 private constant SCALE = 1e18;

    mapping(bytes32 => uint256) public emissionFactors;
    mapping(address => uint256) public balances;

    event CreditsAllocated(address indexed user, uint256 credits);
    event CreditsRedeemed(address indexed user, uint256 credits);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    function setEmissionFactor(bytes32 _vehicleType, uint256 _emissionFactor) public onlyOwner {
        emissionFactors[_vehicleType] = _emissionFactor;
    }

    function allocateCredits(address _user, uint256 _distanceTraveled, bytes32 _vehicleType) external onlyOwner {
        uint256 emissionFactor = emissionFactors[_vehicleType];
        require(emissionFactor > 0, "Emission factor not set for vehicle type");
        uint256 credits = (_distanceTraveled * SCALE) / emissionFactor;
        balances[_user] += credits;
        emit CreditsAllocated(_user, credits);
    }

    function redeemCredits(uint256 _credits) external {
        require(balances[msg.sender] >= _credits, "Insufficient credit balance");
        balances[msg.sender] -= _credits;
        emit CreditsRedeemed(msg.sender, _credits);
    }

    function getBalance(address _user) external view returns (uint256) {
        return balances[_user];
    }

    function getEmissionFactor(bytes32 _vehicleType) external view returns (uint256) {
        return emissionFactors[_vehicleType];
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner is the zero address");
        owner = newOwner;
    }
}
