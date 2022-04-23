// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
 * Array - dynamic or fixed size
 * Initialization
 * Insert (push), get, update, delete, pop, length
 * Creating array in memory
 */

contract Array {
    uint256[] public nums = [1, 2, 3];
    uint256[3] public numsFixed = [4, 5, 6];

    function examples() external {
        nums.push(4); //* [1, 2, 3, 4]
        uint256 x = nums[1]; //* 2
        nums[2] = 777; //* [1, 2, 777, 4]
        delete nums[1]; //* [1, 0, 777, 4] change to default value
        nums.pop(); //* [1, 0, 777] remove last elem
        uint256 len = nums.length;

        //* create array in memory
        uint256[] memory a = new uint256[](5);
        //* memory array 에는 array size를 바꿀 수 없다.
        // a.pop();
        // a.push(1);
        a[1] = 123;
    }

    function returnArray() external view returns (uint256[] memory) {
        return nums;
    }
}
