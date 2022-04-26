// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* selfdestruct
//* - delete contract
//* - force send Ether to any address

//* 블록체인에서 컨트랙트를 제거한다.
//* 제거하면서 balance를 보낼 수 있다.

contract Kill {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function testCall() external pure returns (uint) {
        return 123;
    }
}

//* Kill 컨트랙트의 kill을 호출하는 컨트랙트
contract Helper {
    function getBalance() external view returns (uint) {
        return address(this).balance;
    }

    function kill(Kill _kill) external {
        _kill.kill();
    }
}