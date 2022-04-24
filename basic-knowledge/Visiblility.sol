// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
 * visibility
 * private    : only inside contract
 * internal   : only inside contract and child contracts
 * public     : inside and outside contract
 * external   : only from outside contract
 */

contract VisibilityBase {
    uint private x = 0;
    uint internal y = 1;
    uint public z = 2;

    function privateFunc() private pure returns (uint) {
        return 0;
    }

    function internalFunc() internal pure returns (uint) {
        return 100;
    }

    function publicFunc() public pure returns (uint) {
        return 200;
    }

    function externalFunc() external pure returns (uint) {
        return 300;
    }

    function examples() external view {
        x;
        y;
        z;

        privateFunc();
        internalFunc();
        publicFunc();
        //! externalFunc();

        //* 현재 실행중인 함수가 외부에서 호출되었다면 this로 컨트랙트 인스턴스를 참조하여 external function을 호출할 수 있다.
        //* 하지만 gas cost에서 비효율적이기 때문에 사용하지 않는 것이 좋다.
        this.externalFunc();
    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        //! x;
        y;
        z;

        //! privateFunc();
        internalFunc();
        publicFunc();
        //! externalFunc();
    }
}