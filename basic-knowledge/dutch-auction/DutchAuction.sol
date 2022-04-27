// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC721 {
    function tranferFrom(
        address _from,
        address _to,
        uint256 _nftId
    ) external;
}

//* DutchAuction : 처음 올렸던 가격에서 시간이 지남에 따라 가격이 하락하는 경매를 말한다.
contract DutchAuction {
    uint256 private constant DURATION = 7 days;

    IERC721 public immutable nft;
    uint256 public immutable nftId;

    address payable public immutable seller;
    uint256 public immutable startingPrice;
    uint256 public immutable startAt;
    uint256 public immutable expiresAt;
    uint256 public immutable discountRate;

    constructor(
        uint256 _startingPrice,
        uint256 _discountRate,
        address _nft,
        uint256 _nftId
    ) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;
        //* DURATION 뒤에 가격이 0 이상이어야 한다.
        require(
            _startingPrice >= _discountRate * DURATION,
            "starting price < discount"
        );

        nft = IERC721(_nft);
        nftId = _nftId;
    }

    //* 할인폭 * 시간 = 할인액
    //* 가격 = 초기가격 - 할인액
    function getPrice() public view returns (uint256) {
        uint256 timeElapsed = block.timestamp - startAt;
        uint256 discount = discountRate * timeElapsed;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expiresAt, "auction expired");

        uint256 price = getPrice();
        require(msg.value >= price, "ETH < price");

        nft.tranferFrom(seller, msg.sender, nftId);
        uint256 refund = msg.value - price;
        if (refund > 0) {
            payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }
}
