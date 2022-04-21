// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* constant 를 사용하여 상수화하면 가스비를 절약할 수 있다.
contract Constants {
    //* 21442 gas
    address public constant MY_ADDRESS =
        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    uint256 public constant MY_UINT = 123;
}

contract Var {
    //* 23553 gas
    address public MY_ADDRESS = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}
