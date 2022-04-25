// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* 다른 컨트랙트에서 컨트랙트를 디플로이할 수 있다.
contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}

contract AccountFactory {
    Account[] public accounts;

    //* ETH를 value에 넣어서 호출(payable) -> Account 컨트랙트를 ETH와 함꼐 디플로이
    function createAccount(address _owner) external payable {
        Account account = new Account{value: msg.value}(_owner);
        accounts.push(account);
    }
}