// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/*
 * Calling parent functions
 * - direct
 * - keyword 'super'

 *    E
 *  /  \
 * F    G
 *  \  /
 *   H
 */

contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public virtual override {
        emit Log("F.foo");
        E.foo(); //* Directly call E's function
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar(); //* Use keyword super
    }
}

contract G is E {
    function foo() public virtual override {
        emit Log("G.foo");
        E.foo();
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();
    } 
}

contract H is F, G {
    function foo() public override(F, G) {
        //* F.foo -> E.foo
        F.foo(); 
    }

    function bar() public override(F, G) {
        //* call bar functions of all parents 
        super.bar(); //* G.bar + F.bar + E.bar
    }
}