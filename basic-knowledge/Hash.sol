// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract HashFunc {
    //* keccak256함수를 통해 단방향 암호화된 값을 얻는다.
    function hash(string memory text, uint num, address addr) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text, num, addr));
    }

    function encode(string memory text0, string memory text1) external pure returns (bytes memory) {
        return abi.encode(text0, text1);
    }

    function encodePacked(string memory text0, string memory text1) external pure returns (bytes memory) {
        return abi.encodePacked(text0, text1);
    }

    //* text0 = "AAA", text1 = "BBB" 일 경우
    //* encode -> bytes: 0x00000000000000000000000000000000000000000000000000000000000000400000000000
    //*                  0000000000000000000000000000000000000000000000000000800000000000000000000000
    //*                  0000000000000000000000000000000000000000034141410000000000000000000000000000
    //*                  0000000000000000000000000000000000000000000000000000000000000000000000000000
    //*                  0000000000000000034242420000000000000000000000000000000000000000000000000000000000
    //* encodePacked -> bytes: 0x414141424242

    //* encodePacked("AAAA", "BBB") == encodePacked("AAA", "ABBB") === 0x41414141424242
    //* 두 문자열을 합친후 인코드하기 때문에 값이 동일해진다.
    //* 이로 인해 결과값 충돌이 발생할 수 있다. (독립성, 신뢰성 저하)

    function collision(string memory text0, string memory text1) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(text0, text1));
    }
    //* collision("AAAA", "BBB") == collison("AAA", "ABBB")

    //* 충돌에 대한 대안으로, 다이나믹 타입의 인수 두개를 받을 경우 abi.encode()를 사용하면 되고,
    //* 스태틱 타입의 데이터가 인수로 들어간다면, 사이에 넣어주면 된다. abi.encodePacked(text0, x: uint, text1)
}