// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";


contract HireContract {
    address payable owner;
    uint256 public itemCounter;

    struct HireItem {
        uint256 itemId;
        address fromHire;
        address toStaff;
        uint256 price;
        string des;
        bool isAvailable;
        bool isStart;
        bool isApprove;
        bool isHireFinish;
        bool isStaffFinish;
        Timer timer;

    }

    mapping(uint256 => HireItem) public hireItem;
    
    event HireItemList(
        uint256 indexed hireId,
        address indexed fromHire,
        address toStaff,
        uint256 price,
        string des
    );

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
            strDes,
            true,
            false,
            false,
            false,
            false, 
            new Timer()

        );

        emit HireItemList(
            itemCounter,
            from,
            address(0),
            price,
            strDes
        );
        
        itemCounter += 1;

    }

    // apply job

    function staffApproveJob(address to, uint256 hireId, bool isApprove) public {
        require(hireItem[hireId].fromHire != to, "owner cannot approve");
        hireItem[hireId].isApprove = isApprove;
    }

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

    // finish job by hire
    function finihByHire(address from, uint256 hireId) public {
        require(hireItem[hireId].fromHire == from, "not enough owner");
        hireItem[hireId].isHireFinish = true;

    }

    // finish job by staff
    function finihByStaff(address to, uint256 hireId) public {
        require(hireItem[hireId].toStaff == to, "not enough owner");
        require(hireItem[hireId].isStart == true, "project not start");
        require(hireItem[hireId].isApprove == true, "staff not approve");

        hireItem[hireId].isStaffFinish = true;
    }

    // cancel job 
    function cancelHire(address to, uint256 hireId) public {
        require(hireItem[hireId].fromHire == to, "not enough owner");
        hireItem[hireId].isAvailable = false;

    }
}

contract Timer {
    uint _start;
    uint _end;

    modifier timerOver {
        require(block.timestamp <= _end, "Timne over end");
        _;
    }

    function start() public {
        _start = block.timestamp;
    }

    function end(uint totalTime) public {
        _end = totalTime+ _start;
    } 
    
    function getTimeLeft() public timerOver view returns(uint) {
        return _end - block.timestamp;
    }
}