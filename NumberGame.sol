pragma solidity ^0.4.8;

//everyone stores their own number once
//can get someone else's number
//add that number to your number

contract NumberGame{

    mapping(address => uint) public Numbers;

    function NumberGame(){        //initialize contract
    }

    function storeNumber(uint myNum){
        if(Numbers[msg.sender] != 0) throw;  //if you already stored, throw
        Numbers[msg.sender] = myNum;    //store your number
    }

    function addNumber(address friendAddress) returns (uint newNumber){
        //if(Numbers[friendAddress] == 0) throw;   //friend not stored, but don't want to lose gas if they haven't stored
        if(friendAddress == msg.sender) throw;
        //uint newNumber;
        newNumber = Numbers[friendAddress] + Numbers[msg.sender];        //add looked up number to my number
    }

}
