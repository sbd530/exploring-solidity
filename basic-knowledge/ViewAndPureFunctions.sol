// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ViewAndPureFunctions {
    uint256 public num; //* StateVariable

    function viewFunc() external view returns (uint256) {
        return num;
    }

    function pureFunc() external pure returns (uint256) {
        //! return num; // cannot refer StateVariables
        return 1;
    }

    function addToNum(uint256 x) external view returns (uint256) {
        return num + x;
    }

    //* pure function 은 state변수나 contract, blockchain 을 참조하지 않을 경우 사용한다.
    function addToNum(uint256 x, uint256 y) external pure returns (uint256) {
        return x + y;
    }
}
