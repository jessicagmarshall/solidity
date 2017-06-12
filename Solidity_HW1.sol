pragma solidity ^0.4.8;
//this is a comment

contract JaesToken{
  mapping(address => uint) balances;    //store numtoken in address
  mapping (address => mapping (address => uint)) allowed;
  //store the amount allowed by an address for another address to spend on its behalf
    uint256 public totalSupply;
    uint8 public xChange;     //exchange rate
    string tokenName;

  function JaesToken(uint _initialAmount, string _tokenName){
    //initialize this contract & mint tokens
    balances[msg.sender] = _initialAmount;    //give contract creator all tokens
    totalSupply = _initialAmount;
    tokenName = _tokenName;
    xChange = 10;   //1 ETH = 10 tokens
  }

  function buyToken(uint _amount) {

    balances[msg.sender] += _amount;    //deposit token in account
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
    if ((balances[_recipient] + _amount) < balances[_recipient])    //check for overflow
      return false;

    if (balances[msg.sender] >= _amount && _amount > 0) { //make sure sender has money to give
      balances[msg.sender] -= _amount;
      balances[_recipient] += _amount;
      return true;
    }

    else{
        return false;
      }
  }

  function approve(address _spender, uint _value){
    //if(_spender == msg.sender) throw;   //can't authorize yourself
    allowed[msg.sender][_spender] = _value;
  }

  function transferFrom(address _from, address _to, uint _value){
    //allow anyone to transfer pre-approved tokens
    if(balances[_from] < _value) throw;   //if _from doesn't have funds, can't send
    if(_value > allowed[_from][msg.sender]) throw; //can't spend more than authorized to
    if(balances[_to] + _value < balances[_to]) throw;
    balances[_from] -= _value;
    balances[_to] += _value;

  }

}
