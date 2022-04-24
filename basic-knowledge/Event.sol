// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Event {
    event Log(string message, uint val);
    //* up to 3 index
    event IndexedLog(address indexed sender, uint val); //* Index 를 사용하여 나중에 로그를 빠르게 찾고 싶을 경우 index 키워드를 사용한다.

    //* 이벤트를 emit하면 해당 기록은 트랜잭션에 기록된다.
    //* Transactional function 이기 때문에 pure, view 를 쓰지 않는다.
    function example() external {
        emit Log("foo", 1234);
        emit IndexedLog(msg.sender, 789);
    }

    event Message(address indexed _from, address indexed _to, string message);

    //* chat app 등에서 보낸 사람과 받은 사람의 채팅 로그를 조회할 수 있다.
    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}