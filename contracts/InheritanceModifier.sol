pragma solidity ^0.8.3;

import "./Owned.sol";


contract InheritanceModifierExample is Owned{

 mapping(address => uint) public tokenBalance;
 mapping(address=>uint) public balances;

// const balances={address:uint}
// balances[address]=uint
// address=msg.sender


 uint tokenPrice = 1 ether;

 constructor() {
 tokenBalance[owner] = 100;
 }

 function createNewToken() public onlyOwner {
 tokenBalance[owner]++;
 }

 function burnToken() public onlyOwner{
 tokenBalance[owner]--;
 }

 function purchaseToken() public payable {
 require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "not enough tokens");
 tokenBalance[owner] -= msg.value / tokenPrice;
 tokenBalance[msg.sender] += msg.value / tokenPrice;
 }

 function sendToken(address _to, uint _amount) public {
 require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
 assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
 assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender])
;
 tokenBalance[msg.sender] -= _amount;
 tokenBalance[_to] += _amount;
 }

}