// SPDX-License-Identifier: MIT

pragma solidity ^0.8.11;

contract VendingMachine {

    address public owner;
    mapping(address => uint) public donutBalances;


    constructor() {
        owner = msg.sender;

        // Here we are setting the initial balance of donuts to 100 and we are using the address of the contract
        // as the address determining what is the total
        donutBalances[address(this)] = 100;
    }

    // Here we want to return the amount of donuts.
    // We dont want to return the balance of someone but rather of the vending machine
    function getVendingMachineBalance() public view returns(uint) {
        return donutBalances[address(this)];
    }

    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock this machine.");
        donutBalances[address(this)] += amount;
    }

    function purchase(uint amount) public payable {
        // This checks if the buyer sent enough money to purchase a donut for 2 eth each
        require(msg.value >= amount * 2 ether, "You must pay at least 2 ether per donut.");
        // Here we check if the vending machine has enough donuts left to fulfill the order amoount
        require(amount <= donutBalances[address(this)], "Not enough donuts.");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }


}