pragma solidity ^0.8.17;

contract challengeOne {

	string public password;

	constructor(string memory _password) payable {
		password = _password;
	}

	// check if two given strings are equal by hashing them and comparing their hash
	function _stringIsEqual(string memory a, string memory b) internal pure returns (bool) {
		return keccak256(bytes(a)) == keccak256(bytes(b));
	}

	function withdrawMoney(string memory _password, uint256 amount) external {
		require(_stringIsEqual(_password, password), "incorrect password!"); // check if password is correct
		(bool success,) = payable(msg.sender).call{value:amount}(""); // send money to msg.sender
		require(success, "transfer failed");
	}

	function isSolved() external view returns (bool) {
		// OBJECTIVE: drain the contract funds
		return address(this).balance == 0;
	}

}
