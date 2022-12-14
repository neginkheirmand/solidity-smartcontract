// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Showcase payment transfers, enums, modifiers & events

contract HotelRoom {
    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses public currentStatus;

    event Occupy(address _occupant, uint256 _value);

    address payable public owner;
    address public occupier;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant() {
        require(currentStatus == Statuses.Vacant, "Currently occupied.");
        _;
    }

    modifier costs(uint256 _amount) {
        require(msg.value >= _amount, "Not enough Ether provided.");
        _;
    }

    //function used to book a hotel room
    function book() public payable onlyWhileVacant costs(2 ether) { 
        currentStatus = Statuses.Occupied;
        occupier = msg.sender;

        // owner.transfer(msg.value);
        (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        require(sent);

        emit Occupy(msg.sender, msg.value);
    }

    function doneWithStay() public {
        require(msg.sender==occupier, "only the occupier can call this function");
        currentStatus = Statuses.Vacant;
    }
}