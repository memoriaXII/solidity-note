pragma solidity ^0.5.11;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";


contract LibrariesExample {

    using SafeMath for uint;


    mapping(address=>uint) public tokenBalance;

    constructor() public {
        tokenBalance[msg.sender]=1;
    }

    function sendToken(address _to, uint _amount)public returns(bool) {
        //prev=> tokenBalance[msg.sender]-= _amount;
        tokenBalance[msg.sender]=tokenBalance[msg.sender].sub(_amount);

        //prev=> tokenBalance[_to]+=_amount;
        tokenBalance[_to]=tokenBalance[_to].add(_amount);
        
        return true;


    }

    //mapping(address => uint) balances;

    // const balances={adderss:uint};
    // balances[address]=uint;
}