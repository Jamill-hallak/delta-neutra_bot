// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IVault {
    struct WithdrawOrder {
        // Account that created this withdraw order
        address account;
        // Amount of remaining shares. This amount is locked by the contract.
        uint256 shares;
        // Maximum amount of WETH to send to `account`
        uint256 weth;
    }

    function getWithdrawOrder(bytes32 key)
        external
        view
        returns (WithdrawOrder memory);
    function removeWithdrawOrder(bytes32 key, bool ok) external;
}
