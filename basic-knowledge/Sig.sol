// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
 * [Process to verify signature]
 * 0. message to sign
 * 1. hash(message)
 * 2. sign(hash(message), private key) | offchain
 * 3. ecrecover(hash(message), signature) == signer
 */

contract VerifySig {
    function verify(address _signer, string memory _message, bytes memory _sig) external pure returns (bool) {
        bytes32 messageHash = getMessageHash(_message);
        bytes32 ethSignedMessageHash = getEthSignedMessageHash(messageHash);

        return recover(ethSignedMessageHash, _sig) == _signer;
    }

    function getMessageHash(string memory _message) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(_message));
    }

    //* hash된 메시지에 prefix를 붙여 다시 hash한다.
    function getEthSignedMessageHash(bytes32 _messageHash) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32",
            _messageHash
        ));
    }

    //* hash된 prefix붙은 메세지와 서명(블록트랜잭션에 기록할 때 생기는 서명)을 비교하여 일치하는지 확인한다. 
    function recover(bytes32 _ethSignedMessageHash, bytes memory _sig) public pure returns (address) {
        (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
        return ecrecover(_ethSignedMessageHash, v, r, s);
    }

    //* 서명을 r, s, v로 쪼갠다.
    function _split(bytes memory _sig) internal pure returns (bytes32 r, bytes32 s, uint8 v) {
        //* 32bytes(bytes32) + 32bytes(bytes32) + 1byte(uint8) == 65 bytes
        require(_sig.length == 65, "invalid signature length");

        //* mload : load from memory
        //* add(배열, skip할 숫자)
        //* _sig -> pointer
        //* pointer 32번까지는 배열의 이름이 들어가는 공간
        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96))) //* only need the first byte
        }
    }
}