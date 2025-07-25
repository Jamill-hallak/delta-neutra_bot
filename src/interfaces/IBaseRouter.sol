// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

interface IBaseRouter {
    function sendWnt(address receiver, uint256 amount) external payable;
    function sendTokens(address token, address receiver, uint256 amount)
        external
        payable;
    function sendNativeToken(address receiver, uint256 amount)
        external
        payable;
}
