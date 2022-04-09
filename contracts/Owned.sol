pragma solidity ^0.8.3;


contract Owned {
    address owner;
    
    constructor(){
        owner=msg.sender;
    }

    modifier onlyOwner(){
      require(msg.sender==owner,"you are not allowed");
      _;
    }

  
}