// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* 이더를 입금받는 건 모두 받고 나서, 출금할 때 deploy했던 owner가 모든 이더를 채가고, 컨트랙트를 제거한다.
contract PiggyBank {
    event Deposit(uint amount);
    event Withdraw(uint amount);

    //* deploy시에 초기화되고 나서 조작할 함수를 만들지 않음
    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "not owner");
        emit Withdraw(address(this).balance);
        selfdestruct(payable(msg.sender));
    }
}