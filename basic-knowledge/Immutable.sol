// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* immutable 키워드로 디플로이 시에 한번만 할당하여 가스를 절약한다.
contract Immutable {
    
    //* 45718 gas
    //* state var 가 동적으로 변한다면 gas 소모가 증가한다.
    //* address public owner = msg.sender;
    
    //* 43585 gas
    //* immutable은 디플로이 시에 초기화 되고, 변경되지 않는다.
    address public immutable owner;

    //* constant 변수는 deploy와 관계없이 항상 초기화되어 있어야한다. (정적값에 어울림)
    string public constant text = "abcd";

    constructor () {
        owner = msg.sender;
    }

    uint public x;

    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }
}