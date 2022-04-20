// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//*public - all can access
//*external - Cannot be accessed internally, only externally
//*internal - only this contract and contracts deriving from it can access
//*private - can be accessed only from this contract

contract FunctionIntro {
    //* public : Solidity immediately copies data to memory.
    //* external : External functions can read directly from calldata. Memory allocation is expensive, whereas reading from calldata is cheap.
    //* pure : function is read-only
    function add(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }

    function sub(uint256 x, uint256 y) external pure returns (uint256) {
        return x - y;
    }
}
