// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* Return multiple outputs
//* Named outputs
//* Destructuring Assignment

contract FunctionOutputs {
    //? 21543 gas
    function returnMany() public pure returns (uint256, bool) {
        return (1, true);
    }

    //? 21521 gas
    function named() public pure returns (uint256 x, bool b) {
        return (1, true);
    }

    //? 21565 gas
    function assigned() public pure returns (uint256 x, bool b) {
        x = 1;
        b = true;
    }

    //? 21322 gas
    function destructuringAssignment() public pure {
        (uint256 x, bool b) = returnMany();
        (, bool _b) = returnMany();
    }
}
