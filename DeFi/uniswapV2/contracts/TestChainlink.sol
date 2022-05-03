// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interfaces/AggregatorV3Interface.sol";

//* 스마트 컨트랙트 세계에선 1ETH가 몇 USD인지 알 수가 없다.
//* 이를 위해 오라클을 사용하여 현실세계의 가치를 가져올 수 있다.
contract TestChainlink {
    AggregatorV3Interface internal priceFeed;

    constructor() {
        //* ETH / USD : 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        priceFeed = AggregatorV3Interface(
            0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        );
    }

    function getLatestPrice() public view returns (int256) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        //* for ETH / USD price is scaled up by 10 ** 8
        return price / 1e8;
    }
}
