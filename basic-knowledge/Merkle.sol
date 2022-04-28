// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
            0        Merkel root
        /       \
      0           1
    /   \       /   \
  0      1     2     3
 / \    / \   / \   / \
0   1  2  3  4   5 6   7
*/

contract MerkleProof {
    function verify(
        bytes32[] memory proof,
        bytes32 root,
        bytes32 leaf,
        uint256 index
    ) public pure returns (bool) {
        bytes32 hash = leaf;

        //* recompute merkle root
        for (uint256 i = 0; i < proof.length; i++) {
            if (index % 2 == 0) {
                hash = keccak256(abi.encodePacked(hash, proof[i]));
            } else {
                hash = keccak256(abi.encodePacked(proof[i], hash));
            }

            index = index / 2;
        }

        return hash == root;
    }
}
