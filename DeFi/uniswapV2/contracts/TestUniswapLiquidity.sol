// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "./interfaces/IERC20.sol";
import "./interfaces/Uniswap.sol";

contract TestUniswapLiquidity {
    //* Uniswap factory contract
    address private constant FACTORY =
        0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f;
    //* Uniswap router
    address private constant ROUTER =
        0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    //* wETH
    address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    event Log(string message, uint256 val);

    //* 유동성 추가
    function addLiquidity(
        address _tokenA,
        address _tokenB,
        uint256 _amountA,
        uint256 _amountB
    ) external {
        //* 1. 거래에 관련된 두가지 토큰을 전송
        IERC20(_tokenA).transferFrom(msg.sender, address(this), _amountA);
        IERC20(_tokenB).transferFrom(msg.sender, address(this), _amountB);
        //* 2. 두가지 토큰을 사용하는 것을 승인
        IERC20(_tokenA).approve(ROUTER, _amountA);
        IERC20(_tokenB).approve(ROUTER, _amountB);
        //* 3. 유니스왑 라우터의 addLiquidity() 호출
        (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        ) = IUniswapV2Router(ROUTER).addLiquidity(
                _tokenA,
                _tokenB,
                _amountA,
                _amountB,
                1,
                1,
                address(this),
                block.timestamp
            );

        emit Log("amountA", amountA);
        emit Log("amountB", amountB);
        emit Log("liquidity", liquidity);
    }

    function removeLiquidity(address _tokenA, address _tokenB) external {
        //* 두 토큰의 유동성 컨트랙트 조회
        address pair = IUniswapV2Factory(FACTORY).getPair(_tokenA, _tokenB);
        //* 유동성 컨트랙트의 잔액 조회
        uint256 liquidity = IERC20(pair).balanceOf(address(this));
        //* 모든 유동성을 burn하기 위해 라우터에 유동성을 승인한다.
        IERC20(pair).approve(ROUTER, liquidity);
        //*
        (uint256 amountA, uint256 amountB) = IUniswapV2Router(ROUTER)
            .removeLiquidity(
                _tokenA,
                _tokenB,
                liquidity,
                1,
                1,
                address(this),
                block.timestamp
            );

        emit Log("amountA", amountA);
        emit Log("amountB", amountB);
    }
}
