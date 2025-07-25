// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IRoleStore {
    function getRoleMembers(bytes32 roleKey, uint256 start, uint256 end)
        external
        view
        returns (address[] memory);
}
