// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RideTransactions {
    struct Ride {
        uint256 id;
        address user;
        address driver; 
        uint256 startTime;
        uint256 estimatedEndTime;
        uint256 finalCost;
        bool completed;
    }

    uint256 public constant SCALE = 1e18; // Scale factor for fixed-point arithmetic
    uint256 public costPerUnit;

    uint256 public nextRideId;
    mapping(uint256 => Ride) public rides;

    event RideStarted(uint256 indexed rideId, address indexed user, address indexed driver, uint256 startTime);
    event RideCompleted(uint256 indexed rideId, uint256 finalCost);
    event PaymentProcessed(uint256 indexed rideId, uint256 amount, address indexed user);
    event RideCancelled(uint256 indexed rideId);

    constructor() {
        nextRideId = 1;
        costPerUnit = 10 * SCALE;
    }

    function startRide( address _user, uint256 _estimatedEndTime) public {
        uint256 _rideId = nextRideId;
        rides[nextRideId] = Ride(_rideId, _user, msg.sender, block.timestamp, _estimatedEndTime, 0, false);
        emit RideStarted(_rideId, _user, msg.sender, block.timestamp);
        nextRideId++;
    }

    function completeRide(uint256 _rideId, uint256 distance) public {
        Ride storage ride = rides[_rideId];
        require(!ride.completed, "Ride already completed");
        require(msg.sender == ride.driver, "Only the driver can complete the ride");

        uint256 scaledDistance = distance * SCALE;
        uint256 finalCost = (scaledDistance * costPerUnit) / SCALE;
        ride.finalCost = finalCost;
        ride.completed = true;

        emit RideCompleted(_rideId, finalCost);
    }

    function processPayment(uint256 _rideId) public payable {
        Ride storage ride = rides[_rideId];
        require(ride.completed, "Ride not completed");
        require(msg.sender == ride.user, "Only the user can make the payment");
        require(msg.value >= ride.finalCost, "Insufficient payment");

        payable(ride.driver).transfer(msg.value);

        emit PaymentProcessed(_rideId, msg.value, msg.sender);
    }

    function cancelRide(uint256 _rideId) external {
        Ride storage ride = rides[_rideId];
        require(msg.sender == ride.driver || msg.sender == ride.user, "Only the driver or customer can cancel the ride");
        require(!ride.completed, "Ride is already completed");

        // Logic to handle refunds or cancellation fees can be added here

        ride.completed = true; // Mark the ride as completed to prevent further actions
        emit RideCancelled(_rideId);
    }
    
    // Getter to retrieve ride details
    function getRideDetails(uint256 _rideId) external view returns (Ride memory) {
        return rides[_rideId];
    }

    // setter for cost per unit
    function setCostPerUnit(uint256 _costPerUnit) external {
        costPerUnit = _costPerUnit;
    }
}
