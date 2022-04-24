// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// contract Counter {
//     uint256 public count;

//     function inc() external {
//         count += 1;
//     }

//     function dec() external {
//         count -= 1;
//     }
// }

//* interface를 사용하면 이미 생성된 컨트랙트의 코드를 복붙할 필요없이,
//* 재사용할 컨트랙트의 address를 알면, 인터페이스로 만들어 재사용할 수 있다. 

interface ICounter {
    function count() external view returns (uint);
    function inc() external;
}

contract CallInterface {
    uint public count;

    function examples(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
}