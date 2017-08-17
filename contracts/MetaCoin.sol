pragma solidity ^0.4.4;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin {
	address minter;
	mapping (address => uint) balances;

	event Transfer(address indexed _from, address indexed _to, uint256 _value);

	function MetaCoin() {
		minter = msg.sender;
		balances[minter] = 10000;
	}

	function mint(address receiver, uint amount) returns(bool mintSucceed) {
		// Only owner of contract could add money to an address
		if (minter != msg.sender) {
			return false;
		}

		balances[receiver] = amount;
		return true;
	}

	function sendCoin(address receiver, uint amount) returns(bool sufficient) {
		if (balances[msg.sender] < amount) {
			return false;
		}
		balances[msg.sender] -= amount;
		balances[receiver] += amount;
		// Transfer event will be fired when coin being sent successfully
		// to listen to this event, you could do
		// MetaCoin.Transfer().watch({}, '', function(error, result) {
		//		if (!error) {
		//				console.log("Coin transfer: " + result.args._amount +
		//						" coins were sent from " + result.args._from +
		//						" to " + result.args._to + ".");
		//				console.log("Balances now:\n" +
		//						"Sender: " + MetaCoin.getBalance(result.args.from) +
		//						"Receiver: " + MetaCoin.getBalance(result.args.to));
		//		}
		//})
		Transfer(msg.sender, receiver, amount);
		return true;
	}

	function getBalanceInEth(address addr) returns(uint) {
		return ConvertLib.convert(getBalance(addr),2);
	}

	function getBalance(address addr) returns(uint) {
		return balances[addr];
	}
}
