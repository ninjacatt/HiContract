pragma solidity ^0.4.4;

contract HiContract {

  address public owner;
  mapping(address => uint) balances;
  // constructor run upon contract creation 
  function HiContract() {
    // when contract first deploy, set owner
    owner = msg.sender; // address that sending the transaction
    balances[owner] = 1000; // initial value for owner balance of 1000
  }

  function getBalance(address user) constant returns (uint) { 
    // constant since this function will not change state of object
    return balances[user];
  }

  function transfer(address to, uint value) returns (bool) {
    address from = msg.sender;
    // check to see if from has enough money to send
    if (balances[from] >= value) {
      balances[from] = balances[from] - value;
      balances[to] = balances[to] + value;
      return true;
    }
    return false;
  }
}