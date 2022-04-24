// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract CallTestContract {
    function setX(TestContract _test, uint _x) external {
        _test.setX(_x);
    }
    //* 컨트랙트를 동적으로 호출하려면 대상 컨트랙트의 address를 받도록 설정한다.
    function getX(address _test) external view returns (uint x) {
        x = TestContract(_test).getX();
    }

    function setXandSendEther(address _test, uint _x) external payable {
        TestContract(_test).setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(address _test) external view returns (uint x, uint value) {
        (x, value) = TestContract(_test).getXandValue();
    }
}

contract TestContract {
    uint public x;
    uint public value = 123;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReceiveEther(uint _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}