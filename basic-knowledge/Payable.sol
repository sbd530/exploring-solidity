// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* ETH 와 관련된 작업을 위해서 payable이 필요하다.

contract Payable {
    //* ether를 전송받기 위해 payable로 선언한다.
    address payable public owner;

    constructor() {
        //* payable 로 cast
        owner = payable(msg.sender);
    }

    //* payable function을 통해 value에 이더를 넣어 전송할 수 있다.
    function deposit() external payable {}

    function getBalance() external view returns (uint) {
        return address(this).balance;
    }
}