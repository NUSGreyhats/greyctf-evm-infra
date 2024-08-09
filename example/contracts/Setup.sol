// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./challengeOne.sol";
import "./challengeTwo.sol";
import "./challengeThree.sol";

contract Setup {
	
	challengeOne public challenge1;
	challengeTwo public challenge2;
	challengeThree public challenge3;

	constructor() payable {
		challenge1 = (new challengeOne){value: 5 ether}("secretpassword");
		challenge2 = (new challengeTwo){value: 50 ether}();
		challenge3 = (new challengeThree){value: 100 ether}();
	}

    function isSolved0() public view returns (bool) {
        return challenge1.isSolved();
    }
    function isSolved1() public view returns (bool) {
        return challenge2.isSolved();
    }
    function isSolved2() public view returns (bool) {
        return challenge3.isSolved();
    }
}
