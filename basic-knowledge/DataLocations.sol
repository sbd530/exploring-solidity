// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* Data locations - storage, memory and calldata

contract DataLocations {
    struct MyStruct {
        uint foo;
        string text;
    }

    mapping(address => MyStruct) public myStructs;

    //* input과 output에 memory를 사용할 수 있다.
    function example1(uint[] memory y, string memory s) external returns (MyStruct memory, uint[] memory) {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});

        MyStruct storage myStruct = myStructs[msg.sender]; //* strage = state variable
        //* To modifiy the state variable 
        myStruct.text = "foo";

        MyStruct memory readOnly = myStructs[msg.sender]; //* memory 상에만 저장
        readOnly.foo = 456; //* Cannot modify the state variable 

        uint[] memory memArr = new uint[](3);
        memArr[0] = 234;

        return (readOnly, memArr);
    }

    //* input 에 memory를 사용한다면, calldata를 메모리에 복사해주는 작업이 필요로 해진다. 
    //* function input에 calldata를 씀으로써 gas를 절약할 수 있다.
    //* Gas cost : {memory_input=75707}, {calldata_input=43005}
    function example2(uint[] calldata y, string calldata s) external returns (MyStruct memory, uint[] memory) {
        myStructs[msg.sender] = MyStruct({foo: 123, text: "bar"});

        MyStruct storage myStruct = myStructs[msg.sender]; //* strage = state variable
        //* To modifiy the state variable 
        myStruct.text = "foo";

        MyStruct memory readOnly = myStructs[msg.sender]; //* memory 상에만 저장
        readOnly.foo = 456; //* Cannot modify the state variable 

        _internal(y); //* here

        uint[] memory memArr = new uint[](3);
        memArr[0] = 234;
        
        return (readOnly, memArr);
    }

    //* calldata를 그대로 받아와서 내부적인 연산이 필요하면, 계속해서 calldata를 매개변수로 취하여 gas를 절약하면 된다.
    function _internal(uint[] calldata y) private {
        uint x = y[0];
    }
}