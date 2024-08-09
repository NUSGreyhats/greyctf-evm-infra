pragma solidity ^0.8.17;

contract challengeThree {

	mapping(address => uint256) public balances;

	constructor() payable {}

    // Deposit Ether into the contract
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // Withdraw all your balance
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Insufficient balance");

        // Send Ether to the caller
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        // Update balance after sending Ether
        balances[msg.sender] = 0;
    }

    // Get the balance of the caller
    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }

	function isSolved() external view returns (bool) {
		// objective is to drain this contract
		return address(this).balance == 0;
	}

}
