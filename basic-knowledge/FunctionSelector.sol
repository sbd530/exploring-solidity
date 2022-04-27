// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract FunctionSelector {
    function getSelector(string calldata _func) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
        //* when _func is "transfer(address,uint256)"
        //* return 0xa9059cbb
    }
}

contract Receiver {
    event Log(bytes data);

    function transfer(address _to, uint256 _amount) external {
        emit Log(msg.data);
        //? logdata = 0xa9059cbb0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc4000000000000000000000000000000000000000000000000000000000000000b
        //* 0xa9059cbb                                                        => function selector : byte4
        //* 0000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc   => _to               : address
        //* 4000000000000000000000000000000000000000000000000000000000000000b => _amount           : uint256
    }
}
