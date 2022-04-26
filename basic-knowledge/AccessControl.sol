// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract AccessControl {
    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    //* role => account => bool
    mapping(bytes32 => mapping(address => bool)) public roles;

    //* Role constants
    //* 상수 값은 private 으로 숨긴다.
    //* 계속해서 쓰이기 때문에 가스를 절약하기 위해 constant로 고정시킨다.
    //* 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //* 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    modifier onlyRole(bytes32 _role) {
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    //* 최초에 deploy한 사람은 ADMIN을 지닌다. 아무도 ADMIN이 아니면 grantRole() external 을 실행할 수 없기 때문.
    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function grantRole(bytes32 _role, address _account) external onlyRole(ADMIN) {
        _grantRole(_role, _account);
    }

    function revokeRole(bytes32 _role, address _account) external onlyRole(ADMIN) {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }    
}