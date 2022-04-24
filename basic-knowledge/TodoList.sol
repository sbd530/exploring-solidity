// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

//* Insert, update, read from array of struts
contract TodoList {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todos;

    function create(string calldata _text) external {
        todos.push(Todo({
            text: _text,
            completed: false
        }));
    }

    function updateText(uint _index, string calldata _text) external {
        //* 37027 gas (cheaper for the only one command)
        //! todos[_index].text = _text;
        //* 37042 gas
        Todo storage todo = todos[_index];
        todo.text = _text;
        //* 적은 양을 update할 땐 storage가 더 비싸지만, 여러번 작업을 할때는 storage 변수에 담는 쪽이 더 싸다.
    }

    function get(uint _index) external view returns (string memory, bool){
        // memory - 29480
        // storage - 29397 gas
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function toggleCompleted(uint _index) external {
        todos[_index].completed = !todos[_index].completed;
    }
}