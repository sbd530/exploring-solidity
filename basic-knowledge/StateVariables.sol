// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract StateVariables {
    //* stateVariables : 컨트랙트 안, 함수 밖에 존재하고, 선언시 블록체인에 기록된다.
    uint256 public myUint = 123;

    function foo() external {
        //* Local variable 은 함수 실행시에만 존재하게 된다.
        uint256 notStateVarible = 456;
    }
}
