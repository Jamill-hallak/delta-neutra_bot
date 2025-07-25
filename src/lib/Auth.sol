// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Auth {
    event Authorize(address indexed user, bool auth);

    mapping(address => bool) public authorized;

    modifier auth() {
        require(authorized[msg.sender], "not authorized");
        _;
    }

    constructor() {
        authorized[msg.sender] = true;
    }

    function allow(address user) external auth {
        authorized[user] = true;
        emit Authorize(user, true);
    }

    function deny(address user) external auth {
        authorized[user] = false;
        emit Authorize(user, false);
    }
}
