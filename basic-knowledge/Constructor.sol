// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* contract 가 deploy될 때 한번 호출되며, state variables를 초기화한다.

contract Constructor {
    address public owner;
    uint256 public x;

    constructor(uint256 _x) {
        owner = msg.sender;
        x = _x;
    }
}
