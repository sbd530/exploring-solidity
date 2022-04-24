// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Structs {
    struct Car {
        string model;
        uint256 year;
        address owner;
    }

    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;

    function examples() external {
        //* memory : 데이터를 메모리에 할당하여 임시적으로 저장한다.
        Car memory toyota = Car("Toyota", 1990, msg.sender);
        Car memory lambo = Car({
            year: 1980,
            model: "Lamborghini",
            owner: msg.sender
        });
        Car memory tesla;
        tesla.model = "Tesla";
        tesla.year = 2010;
        tesla.owner = msg.sender;

        cars.push(toyota);
        cars.push(lambo);
        cars.push(tesla);

        cars.push(Car("Ferrari", 2020, msg.sender));

        //* 컨트랙트 상의 데이터를 변경하기 위해서는 memory 키워드를 사용하면 안된다.
        //* storage 키워드를 사용함으로써 컨트랙트 데이터의 참조를 읽어오고 직접 수정할 수 있다.
        // Car memory _car = cars[0];
        Car storage _car = cars[0];
        _car.year = 1999;
        delete _car.owner; //* default value 로 초기화

        delete cars[1]; //* Car 구조체의 필드들을 dafault value로 초기화 {model:"",year:0,owner:address(0)}
    }
}
