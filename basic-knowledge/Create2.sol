// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

//* CREATE2를 이용하면 같은 주소의 컨트랙트에서 다른 컨트랙트를 디플로이할 수 있다.
contract DeployWithCreate2 {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}

contract Create2Factory {
    event Deploy(address addr);

    function deploy(uint256 _salt) external {
        DeployWithCreate2 _contract = new DeployWithCreate2{
            salt: bytes32(_salt)
        }(msg.sender);
        emit Deploy(address(_contract)); //* "addr": "0xb4B8d992716632d326A2e814DF4AD09C5825862f"
    }

    function getAddress(bytes memory bytecode, uint256 _salt)
        public
        view
        returns (address)
    {
        //* 컨트랙트 주소 만들기 : 0xff, address(this), salt, keccak256(init_code)
        //* 충돌을 막기 위해 prefix로 0xff을 사용한다.
        //* address, salt, init_code를 알고있다면 같은 주소의 컨트랙트를 새로 만들 수도 있어 해킹에 취약하다.
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),
                address(this),
                _salt,
                keccak256(bytecode)
            )
        );

        return address(uint160(uint256(hash)));
        //* "0xb4B8d992716632d326A2e814DF4AD09C5825862f"
    }

    function getBytecode(address _owner) public pure returns (bytes memory) {
        bytes memory bytecode = type(DeployWithCreate2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_owner));
    }
}
