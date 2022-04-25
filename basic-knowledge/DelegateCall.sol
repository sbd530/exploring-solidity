// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
 * A calls B, sends 100 wei
 *         B calls C, sends 50 wei
 * A  ---> B  ---> C
 *                 msg.sender = B
 *                 msg.value = 50
 *                 execute code on C's state variables
 *                 use ETH in C
 * A calls B, sends 100 wei
 *         B delegatecall C
 * A  ---> B  ---> C
 *                 msg.sender = A
 *                 msg.value = 100
 *                 execute code on B's state variables
 *                 use ETH in B
 */

contract TestDelegateCall {
    // address public owner; //* 만약 새로운 state var가 추가되는 경우, 기존 변수들의 순서가 바뀌면 이상하게 동작한다.
    uint public num;
    address public sender;
    uint public value;
    address public owner; //* deletegatecall이 동일한 동작을 하기 위해선 가장 밑에 선언해야 한다. 

    function setVars(uint _num) external payable {
        // num = _num;
        num = 2 * _num; //* 대상 컨트랙트가 변경된 후 deploy됐을 때, delegatecall이 이를 적용하려면 새로운 컨트랙트 address를 적용해야한다.
        sender = msg.sender;
        value = msg.value;
    } 
}

//* deletegatecall을 사용하면 TestDelegateCall의 state var는 변경이 없고, DelegateCall 컨트랙트의 state var가 변경된다.
//* 대신 state vars 가 완전히 동일해야 한다.
contract DelegateCall {
    uint public num;
    address public sender;
    uint public value;

    function setVars(address _test, uint _num) external payable {
        // _test.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
        (bool success, bytes memory data) = _test.delegatecall(abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num));
        require(success, "delegatecall failed");
    }   
}