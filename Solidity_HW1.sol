pragma solidity ^0.4.8;
//this is a comment

contract JaesToken{
  mapping(address => uint) balances;    //store numtoken in address
  mapping (address => mapping (address => uint)) allowed;
  //store the amount allowed by an address for another address to spend on its behalf
    uint256 public totalSupply;

  function JaesToken(uint _initialAmount){
    //initialize this contract & mint tokens
    balances[msg.sender] = _initialAmount;    //give contract creator all tokens
    totalSupply = _initialAmount;
  }

  function totalSupply() constant returns (uint256 supply){
      return totalSupply;
  }

  function balanceOf(address _owner) constant returns (uint256 balance){
    //get balance of account with address _owner
    return balances[_owner];
  }

  function transfer(address _recipient, uint256 _amount) returns (bool success){
    //transfer _amount tokens to address _recipient
    if (balances[msg.sender] >= _amount && _amount > 0) {
      balances[msg.sender] -= _amount;
      balances[_recipient] += _amount;
      return true;
    }
    else{
        return false;
      }
  }

  function transferFrom(address _from, address _to, uint _value){
    //allow anyone to transfer pre-approved tokens
  }

  function approve(address _spender, uint _value){

  }
}
