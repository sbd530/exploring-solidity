// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ArrayShift {
    uint256[] public arr;

    function examples() public {
        arr = [1, 2, 3];
        delete arr[1]; //* [1, 0, 3]
    }

    //? [1, 2, 3] -- remove(1) -> [1, 3, 3] -> [1, 3]
    //? [1, 2, 3, 4 ,5 ,6] -- remove(2) -> [1, 2, 4, 5, 6, 6]
    //? -> [1, 2, 4, 5, 6]
    //? [1] -- remove(0) -> [1] -> []
    //* 제거 하려는 원소의 오른쪽 원소들을 왼쪽으로 한칸씩 옮기고, 마지막 원소를 제거
    function remove(uint256 _index) public {
        //* index 검증
        require(_index < arr.length, "index out of bound");
        //* 왼쪽으로 이동
        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        //* 마지막 원소 제거
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);
        //* []
        assert(arr.length == 0);
    }
}
