// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* remove array element by shifting elements  to left
//* [1,2,3,4,5,6] -- remove(2) -> [1,2,4,5,6,6] -> [1,2,4,5,6]
//! 시프팅 방식은 gas가 많이 든다.
//! sorting이 필요없다면 마지막 원소를 복사하여 pop하는 방식이 효율적이다.

//* [1,2,3,4] -- remove(1) -> [1,4,3]
//* [1,4,3] -- remove(2) -> [1,4]

contract ArrayRepalceLast {
    uint256[] public arr;

    function remove(uint256 _index) public {
        //* 제거 대상 원소에 마지막 원소를 교체
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4];

        remove(1); //* [1,4,3]

        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2); //* [1,4]

        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}
