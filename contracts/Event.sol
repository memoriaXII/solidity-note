pragma solidity ^0.8.3;

contract Event{
    mapping(address=>uint) public balances;

    event TokenSent(address _from,address _to,uint _amount);

     constructor(){
        balances[msg.sender]=100;
    }

    function sendToken(address _to, uint _amount) public returns(bool){
        require(balances[msg.sender]>=_amount,"tokens not enought");
        assert(balances[_to]+_amount>=balances[_to]);
        assert(balances[msg.sender]>=balances[msg.sender]-_amount);
        balances[msg.sender]-= _amount;
        balances[msg.sender]+= _amount;


        //觸發 emit event
        emit TokenSent(msg.sender,_to,_amount);


        //event output

        
        // [
	    // {
		// "from": "0xf8e81D47203A594245E36C48e151709F0C19fBe8",
		// "topic": "0x3ddb739c68dd901671f09fbe0bc2344c179ed55f8e8110a7c7a3c5665bd9518d",
		// "event": "TokenSent",
		// "args": {
		// 	"0": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
		// 	"1": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
		// 	"2": "1",
		// 	"_from": "0x5B38Da6a701c568545dCfcB03FcB875f56beddC4",
		// 	"_to": "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2",
		// 	"_amount": "1"
		// }
	    // }
        // ]


        return true;



    }
}