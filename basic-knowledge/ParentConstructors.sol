// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* 2 ways to call parent constructors
//* Order of initialization

contract S {
    string public name;

    constructor (string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor (string memory _text) {
        text = _text;
    }
}

//* 1. static input
contract U is S("s"), T("t") {
    
}

//* 2. dynamic input
contract V is S, T {
    constructor (string memory _name, string memory _text) S(_name) T(_text) {}
}

//* both input
contract VV is S("s"), T {
    constructor (string memory _name, string memory _text) T(_text) {}
}

//! constructor 의 실행 순서는 상속 선언의 컨트랙트 순서에 의존한다.

/*
 * Order of execution
 * 1. S
 * 2. T
 * 3. V0
 */
contract V0 is S, T {
    constructor (string memory _name, string memory _text) S(_name) T(_text) {}
}

/*
 * Order of execution
 * 1. S
 * 2. T
 * 3. V1
 */
 contract V1 is S, T{
    constructor (string memory _name, string memory _text) T(_text) S(_name) {}
}

/*
 * Order of execution
 * 1. T
 * 2. S
 * 3. V2
 */
 contract V2 is T,S {
    constructor (string memory _name, string memory _text) T(_text) S(_name) {}
}