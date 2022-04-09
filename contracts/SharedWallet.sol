// SPDX-License-Identifier: MIT

//1000000000000000000

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable {

    using SafeMath for uint;

    event AllowanceChanged(
        address indexed _fromWho,
        address indexed _fromWhom,
        uint256 oldAmount,
        uint256 newAmount
    );

    //  [{"logIndex":1,"blockNumber":77,"blockHash":"0xb9a6e54f266f3d51a34fd7b4a3f1050b1c0cf91ddd014b499685c2a13f8774f4","transactionHash":"0xa5b00af277d73dbbd4f71f4b44bf5b017898f3f7e78a12e4a973eb62d7e384b0",
    //  "transactionIndex":0,"address":"0xd457540c3f08f7F759206B5eA9a4cBa321dE60DC",
    //   "data":"0x00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001",
    //    "topics":["0x3691d1a86d99355e52b689ca70a7bdf6d80763237a6aa06e5fa43964eac7244b","0x000000000000000000000000ab8483f64d9c6d1ecf9b849ae677dd3315835cb2","0x0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4"],
    //    "id":"log_d953b682"}]

    mapping(address => uint256) public allowance;

    function isOwner() internal view returns (bool) {
        return owner() == msg.sender;
    }

    modifier ownerAllowed(uint256 _amount) {
        require(
            isOwner() || allowance[msg.sender] >= _amount,
            "you are not allowed"
        );
        _;
    }

    function addAllowance(address _who, uint256 _amount) public onlyOwner {
        emit AllowanceChanged(_who, msg.sender, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    function reduceAllowance(address _who, uint256 _amount) internal {
        emit AllowanceChanged(
            _who,
            msg.sender,
            allowance[_who],
            allowance[_who].sub(_amount)
        );
        allowance[_who] = allowance[_who].sub( _amount);
    }
}

contract SharedWallet is Allowance {
    event MoneySent(address indexed _beneficiary, uint256 _amount);
    event MoneyReceived(address indexed _from, uint256 _amount);

      function renounceOwnership() public onlyOwner override view {
        revert("Can't renounce ownership here");
    }


    function withdrawMoney(address payable _to, uint256 _amount)
        public
        payable
        ownerAllowed(_amount)
    {
        require(
            _amount <= address(this).balance,
            "they are not enough funds stored in the smart contract"
        );
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        _to.transfer(_amount);
    }

    // function() external payable {
    //     emit MoneyReceived(msg.sender,msg.value);
    // }
    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);

        //  [
        // 	{
        // 		"from": "0xB302F922B24420f3A3048ddDC4E2761CE37Ea098",
        // 		"topic": "0x27b15ed4cf832749ed39f33a64e4707ed60a761485e41ffec7343ecaddc0c02a",
        // 		"event": "MoneyReceived",
        // 		"args": {
        // 			"0": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
        // 			"1": "1000000000000000000",
        // 			"_from": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
        // 			"_amount": "1000000000000000000"
        // 		}
        // 	}
        // ]
    }
}

// => Prev without openzepplin

// pragma solidity ^0.5.13;
// contract SharedWallet {

//     address public owner;

//     constructor() public {
//         owner=msg.sender;
//     }

//     modifier onlyOwner(){
//          require(owner==msg.sender,'you are not allowed');
//          _;

//     }

//     function withdrawMoney(address payable _to, uint _amount) public payable onlyOwner{
//         _to.transfer(_amount);
//     }

//     function() external payable {

//     }
// }
