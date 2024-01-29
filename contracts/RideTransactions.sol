// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./RewardTransactions.sol";

contract RideTransactions {
    RewardTransactions private rewardsContract;

    enum RideStatus { Pending, Matched, Completed , Cancelled}

    struct Location {
        int256 latitude;  // Latitude, scaled by 1e6
        int256 longitude; // Longitude, scaled by 1e6
    }

    struct Ride {
        uint256 id;
        address user;
        address driver;
        bytes32 vehicleType;
        uint256 distance;
        uint256 startTime;
        uint256 finalCost;
        RideStatus status;
        Location pickUpLocation;
        Location destinationLocation;
    }

    struct RideRequest {
        uint256 rideId;
        address user;
        uint256 requestedTime;
        bytes32 vehicleType;
        RideStatus status;
        Location pickUpLocation;
        Location destinationLocation;
    }

    struct Vehicle {
        address id;
        string model; 
    }

    uint256 public constant SCALE = 1e18; // Scale factor for fixed-point arithmetic
    uint256 public costPerUnit;

    uint256 public nextRideId;
    mapping(uint256 => Ride) public rides;
    mapping(address => RideRequest) public rideRequests;
    mapping(address => Vehicle) public vehicles;

    constructor() {  // constructor -> address _rewardsContractAddress
        address rewardsContractAddress = 0xD05AF94Bb79db680e39c4f71dCf9023c8E2fC732;
        nextRideId = 1;
        costPerUnit = 10 * SCALE;
        rewardsContract = RewardTransactions(rewardsContractAddress);
    }

    event RideStarted(uint256 indexed rideId, address indexed user, address indexed driver, uint256 startTime);
    event RideCompleted(uint256 indexed rideId, uint256 finalCost);
    event PaymentProcessed(uint256 indexed rideId, uint256 amount, address indexed user);
    event RideCancelled(uint256 indexed rideId);
    event RideRequested(uint256 indexed rideId, address indexed user, bytes32 vehicleType, uint256 requestedTime);
    event RideAccepted(uint256 indexed rideId, address indexed user, address indexed driver);

    function requestRide(
        bytes32 _vehicleType, 
        Location memory _pickUpLocation, 
        Location memory _destinationLocation
    ) public {
        uint256 _rideId = nextRideId++;
        rideRequests[msg.sender] = RideRequest(
            _rideId, 
            msg.sender, 
            block.timestamp, 
            _vehicleType, 
            RideStatus.Pending,
            _pickUpLocation,
            _destinationLocation
        );
        emit RideRequested(_rideId, msg.sender, _vehicleType, block.timestamp);
    }

    function startRide(
        address _user,
        Location memory _pickUpLocation
    ) public {
        RideRequest storage request = rideRequests[_user];
        require(request.rideId != 0, "Ride not requested");
        require(request.status == RideStatus.Pending, "Ride already started");
        require(msg.sender != _user, "Driver cannot be the user");

        request.status = RideStatus.Matched;
        rides[request.rideId] = Ride(
            request.rideId, 
            _user, 
            msg.sender, 
            request.vehicleType, 
            0, 
            block.timestamp,
            0, 
            RideStatus.Matched,
            _pickUpLocation,
            request.destinationLocation
        );
        emit RideAccepted(request.rideId, _user, msg.sender);
        emit RideStarted(request.rideId, _user, msg.sender, block.timestamp);
    }

    function completeRide(
        uint256 _rideId, 
        uint256 _distance, 
        Location memory _destinationLocation
    ) public {
        Ride storage ride = rides[_rideId];
        require(ride.status == RideStatus.Matched, "Ride not in Matched status");
        require(msg.sender == ride.driver, "Only the driver can complete the ride");

        uint256 scaledDistance = _distance * SCALE;
        uint256 finalCost = (scaledDistance * costPerUnit) / SCALE;
        ride.finalCost = finalCost;
        ride.distance = _distance;
        ride.status = RideStatus.Completed;
        ride.destinationLocation = _destinationLocation;

        emit RideCompleted(_rideId, finalCost);
    }

    function processPayment(
        uint256 _rideId
    ) public payable {
        Ride storage ride = rides[_rideId];
        require(ride.status == RideStatus.Completed, "Ride not in Completed status");
        require(msg.sender == ride.user, "Only the user can make the payment");
        require(msg.value >= ride.finalCost, "Insufficient payment");

        address driver = ride.driver;
        uint256 finalCost = ride.finalCost;

        delete rides[_rideId];

        payable(driver).transfer(finalCost);
        rewardsContract.allocateCredits(msg.sender, ride.distance, ride.vehicleType);

        if (msg.value > finalCost) {
            payable(msg.sender).transfer(msg.value - finalCost);
        }

        emit PaymentProcessed(_rideId, finalCost, msg.sender);
    }

    function cancelRide(
        uint256 _rideId
    ) public {
        Ride storage ride = rides[_rideId];
        require(ride.status == RideStatus.Matched, "Ride not in Matched status");
        require(msg.sender == ride.driver || msg.sender == ride.user, "Only the driver or user can cancel the ride");

        ride.status = RideStatus.Cancelled;
        emit RideCancelled(_rideId);
    }

     function getRideDetials(uint256 _rideId) public view returns (string memory, Ride memory) {
        if (rides[_rideId].id == 0) {
            return ("Ride not found", Ride(0, address(0), address(0), 0, 0, 0, 0, RideStatus.Pending, Location(0, 0), Location(0, 0)));
        }
        return ("Ride found", rides[_rideId]);
    }

      // Function to get a ride request by address
    function getRideRequest(address requester) public view returns (RideRequest memory) {
        if (rideRequests[requester].rideId == 0) {
            return RideRequest(0, address(0), 0, 0, RideStatus.Pending, Location(0, 0), Location(0, 0));
        }
        return rideRequests[requester];
    }

    function setCostPerUnit(uint256 _costPerUnit) public {
        costPerUnit = _costPerUnit;
    }
}
