pragma solidity ^0.4.8;
//this is a comment

contract JaesToken{
  mapping(address => uint) balances;    //store numtoken in address
  mapping (address => mapping (address => uint)) allowed;
  //store the amount allowed by an address for another address to spend on its behalf
    uint256 public totalSupply;
    uint8 public exchangeRate;     //exchange rate
    string public tokenName;
    address owner;      //deployer of contract
    uint exchangeTemp;
    uint numTokens;
    uint amountWei;

  function JaesToken(uint _initialAmount, string _tokenName) {
    //initialize this contract & mint tokens
    owner = msg.sender;
    balances[owner] = _initialAmount;    //give contract creator all tokens
    totalSupply = _initialAmount;
    tokenName = _tokenName;
    exchangeRate = 10;   //1 ETH = 10 tokens
  }

  function buyToken(uint _amountEther){   //_amountEther is amount ether desired to pay
      numTokens = _amountEther * 10;  //calculate num tokens
      amountWei = _amountEther ** 18; //convert ether to wei

      if (balances[owner] < numTokens) throw;   //not enough tokens
      if (balances[msg.sender] + numTokens < balances[msg.sender]) throw; //overflow
      if (msg.sender.balance < amountWei) throw;    //can't afford tokens
      if (owner.balance + amountWei <= owner.balance) throw;  //overflow
      owner.transfer(amountWei);   //msg.sender transfers wei to owner
      balances[msg.sender] += numTokens;    //deposit token in account
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
    if ((balances[_recipient] + _amount) <= balances[_recipient])    //check for overflow
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
