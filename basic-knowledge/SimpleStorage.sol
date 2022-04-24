// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage {
    string public text;

    //* input = "abcdefg"
    //* calldata -> 51232 gas
    //* memory   -> 51786 gas
    function set(string calldata _text) external {
        text = _text;
    }

    //* state var 의 값을 반환할 때는 memory 에 복사하여 반환해야 한다.
    function get() external view returns (string memory) {
        return text;
    }
}