//SPDX-License-Identifier: MIT

pragma solidity ^0.8.3;


contract FunctionsExample {

    event LogFallback(string message);
    event LogBalance(uint balance);

    mapping(address => uint) public balanceReceived;

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function destroySmartContract() public {
        require(msg.sender == owner, "You are not the owner");
        selfdestruct(owner);
    }

    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "not enough funds.");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    } 

    // function() public  {
    //     emit LogFallback("Fallback");
    //     emit LogBalance(address(this).balance);
    // }


    receive() external payable {
        receiveMoney();
    }
}