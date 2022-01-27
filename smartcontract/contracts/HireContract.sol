// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";


contract HireContract {
    address payable owner;
    uint256 public itemCounter;

    struct HireItem {
        uint256 itemId;
        address fromHire;
        address toHired;
        uint256 price;
        bool isFinish;
        string des;
    }

    mapping(uint256 => HireItem) public hireItem;

    constructor() {
        itemCounter = 0;
        owner = payable(msg.sender);
    }

    // list hiring

    function listHiring(address from, uint256 price, string memory strDes) public {
        require(address(from).balance > price, "not enough price");

        hireItem[itemCounter] = HireItem(
            itemCounter,
            from,
            address(0),
            price,
            false,
            strDes
        );

        itemCounter += 1;

    }

    // apply job

    // deposit
    function hiredDeposit(address from, uint256 hireId, uint256 price) public {

    }

    // update price
    function updatePrice(address from,uint256 hireId, uint256 price) public {
        require(hireItem[hireId].fromHire == from, "not owner");
        hireItem[hireId].price = price;
    }

    // return
    function backMoney(address to, uint256 itemId) public {

    }

    // finish job



}