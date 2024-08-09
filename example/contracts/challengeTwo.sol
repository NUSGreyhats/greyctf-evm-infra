pragma solidity ^0.8.17;

contract challengeTwo {

	bool public solved = false;

    constructor() payable {
        require(msg.value == 50 ether, "Insufficient ETH");
    }

    function flashloan(uint256 amount) external {
		// loan the caller some money
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
        require(address(this).balance >= 50 ether);
    }

    function callMe() external {
		// solve condition: have more than 50 ether and call this function!
        require(msg.sender.balance >= 50 ether, "Insufficient Balance");
        solved = true;
    }

    function isSolved() external view returns (bool) {
        return solved;
    }

	receive() external payable {}
}
