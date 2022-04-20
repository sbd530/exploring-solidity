// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* Data types - values and references

contract ValueTypes {
    bool public b = true;

    //* uint = uint256 0 ~ 2**256 - 1
    //*        uint8   0 ~ 2**8 - 1
    //*        uint16  0 ~ 2**16 -1
    uint256 public u = 123;

    //* int = int256 -2**255 to 2**255 - 1
    //*       int128 -2**127 to 2**127 - 1
    int256 public i = -123;

    int256 public minInt = type(int256).min;
    int256 public maxInt = type(int256).max;
    address public addr = 0x646dB8ffC21e7ddc2B6327448dd9Fa560Df41087;
    bytes32 public b32 =
        0xa3ebd275ae0366777db4af387a0929168317fb34fdcc4e644b9e167e74a5b761;
}
