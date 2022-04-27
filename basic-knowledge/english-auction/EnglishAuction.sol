// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

interface IERC721 {
    function tranferFrom(
        address _from,
        address _to,
        uint256 _nftId
    ) external;
}

//* 보편적인 방식의 경매. 입찰가를 올리면서 경매가 끝나는 시점에 bid가 가장 높은 bidder가 소유한다.
contract EnglishAuction {
    event Start();
    event Bid(address indexed sender, uint256 amount);
    event Withdraw(address indexed sender, uint256 amount);
    event End(address highestBidder, uint256 amount);

    IERC721 public immutable nft;
    uint256 public immutable nftId;

    address payable public immutable seller;
    uint32 public endAt; //* uint32 : 100년의 기간을 사용할 수 있다. => 효율성
    bool public started;
    bool public ended;

    address public highestBidder;
    uint256 public highestBid;
    mapping(address => uint256) public bids;

    constructor(
        address _nft,
        uint256 _nftId,
        uint256 _startingBid
    ) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(msg.sender == seller, "not seller");
        require(!started, "started");

        started = true;
        //* block.timestamp은 기본적으로 타입이 uint256이므로 캐스팅을 해준다.
        endAt = uint32(block.timestamp + 60); //* 블록 타임스탬프로부터 60초 뒤
        nft.tranferFrom(seller, address(this), nftId);

        emit Start();
    }

    //* 최고가보다 더 높게 입찰하면 highestBidder가 된다.
    function bid() external payable {
        require(started, "not started");
        require(block.timestamp < endAt, "ended");
        require(msg.value > highestBid, "value < highest bid");

        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid;
        }

        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
    }

    //* 입찰했지만 입찰액이 밀려나서 highestBidder가 되지 못한 address는 환금을 요청한다.
    function withdraw() external {
        uint256 bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);

        emit Withdraw(msg.sender, bal);
    }

    function end() external {
        require(started, "not started");
        require(!ended, "ended");
        require(block.timestamp >= endAt, "not ended");

        ended = true;

        if (highestBidder != address(0)) {
            //* 토큰이 highestBidder에게 보내지고, highestBid는 seller에게 간다.
            nft.tranferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        } else {
            //* 경매를 마무리하지만 주소값이 이상할 경우, 해당 토큰은 seller에게 돌아간다.
            nft.tranferFrom(address(this), seller, nftId);
        }

        emit End(highestBidder, highestBid);
    }
}
